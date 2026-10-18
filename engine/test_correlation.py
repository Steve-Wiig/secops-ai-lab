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
    interpreter = LLMInterpreter(mock_mode=False) 
    
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
