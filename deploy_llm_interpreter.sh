#!/usr/bin/env bash
set -e

echo "========================================================"
echo " Deploying Tier-2: LLM Interpretation Layer"
echo "========================================================"

# 1. Create the LLM Interpreter
cat << 'PYEOF' > engine/llm_interpreter.py
import requests
import json
import os

class InferenceFailed(Exception):
    pass

class LLMInterpreter:
    """
    P0 Deterministic Prompt Builder & Local LLM Caller.
    Strictly uses local inference endpoints (e.g., Ollama).
    """
    def __init__(self, mock_mode=False):
        # Strictly local endpoint (Ollama default)
        self.ollama_url = os.environ.get("OLLAMA_URL", "http://localhost:11434/api/generate")
        self.model = os.environ.get("LOCAL_MODEL", "llama3")
        self.mock_mode = mock_mode

    def _build_prompt(self, incident_payload: dict) -> str:
        # Extract only necessary context, stripping noisy raw logs
        context = {
            "incident_id": incident_payload["incident_id"],
            "fingerprint": incident_payload["fingerprint"],
            "status": incident_payload["advisory_status"],
            "occurrences": incident_payload["occurrence_count"],
            "entities": incident_payload["entities"],
            "alert_sequence": [
                {"rule": a["rule_id"], "desc": a["description"]} 
                for a in incident_payload["raw_alerts"]
            ]
        }
        
        prompt = f"""You are a Tier-1 SOC Analyst AI. Analyze the following correlated security incident and provide:
1. Executive Summary (1-2 sentences)
2. Threat Intent Assessment
3. Recommended Remediation

INCIDENT DATA:
{json.dumps(context, indent=2)}

Response:"""
        return prompt

    def analyze(self, incident_payload: dict) -> str:
        prompt = self._build_prompt(incident_payload)
        
        if self.mock_mode:
            return "[MOCK LLM] Successful SSH brute force detected from 10.0.0.5 targeting root. Recommend IP ban and credential reset."

        # P0 Fail-Closed Enforcement
        try:
            response = requests.post(
                self.ollama_url,
                json={"model": self.model, "prompt": prompt, "stream": False},
                timeout=5 
            )
            response.raise_for_status()
            return response.json().get("response", "No response generated.")
            
        except (requests.exceptions.ConnectionError, requests.exceptions.Timeout, requests.exceptions.HTTPError) as e:
            # P0 Invariant: Fail closed. Do not silently proceed.
            raise InferenceFailed(f"Local inference unavailable. Fail-closed triggered. ({e})")
PYEOF

# 2. Update test to pass events to the interpreter
cat << 'PYEOF' > engine/test_correlation.py
#!/usr/bin/env python3
import time
from correlation_engine import CorrelationEngine
from llm_interpreter import LLMInterpreter, InferenceFailed

def run_simulation():
    print("========================================================")
    print(" Running End-to-End Pipeline Test (Correlation + Ledger + LLM)")
    print("========================================================")
    
    engine = CorrelationEngine(time_window_sec=60)
    # Set to False to test real Ollama + Fail-Closed invariants
    interpreter = LLMInterpreter(mock_mode=True) 
    
    base_time = time.time() - 1000 
    
    attack_1 = [
        {"rule": {"id": "5710", "description": "sshd: Attempt to login"}, "srcip": "10.0.0.5", "timestamp": base_time},
        {"rule": {"id": "5712", "description": "sshd: Auth success"}, "srcip": "10.0.0.5", "data": {"username": "root"}, "timestamp": base_time + 2},
    ]

    print("[INFO] Ingesting Attack 1...")
    for alert in attack_1:
        engine.ingest(alert)
    engine.flush_expired() 
    
    print("\n[INFO] Sending NEW incidents to LLM Interpreter...")
    for event in engine.ledger_bridge.recorded_events:
        if event["advisory_status"] == "NEW":
            try:
                analysis = interpreter.analyze(event)
                print(f"\n[LLM OUTPUT for {event['incident_id']}]:\n{analysis}")
            except InferenceFailed as e:
                print(f"\n[P0 FAIL-CLOSED TRIGGERED]: {e}")
                print("[SYSTEM] Alert routed to Human Analyst Queue.")

    print("\n========================================================")
    print("Tier-2 Interpretation Layer Online.")
    print("========================================================")

if __name__ == "__main__":
    run_simulation()
PYEOF

echo "Running End-to-End Pipeline test..."
python3 engine/test_correlation.py
