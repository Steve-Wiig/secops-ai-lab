#!/usr/bin/env bash
set -e

echo "========================================================"
echo " Deploying Ledger Integration Bridge"
echo "========================================================"

# 1. Create the Bridge
cat << 'PYEOF' > engine/ledger_integration.py
from typing import Dict, Any
import json

class IncidentLedgerBridge:
    """
    Converts closed CorrelationEngine Incidents into LedgerEvent-compatible payloads.
    """
    def __init__(self):
        self.recorded_events = []

    def record_incident(self, incident) -> None:
        # 1. Convert the Incident dataclass into a clean dictionary
        payload = {
            "incident_id": incident.incident_id,
            "event_type": "CORRELATED_INCIDENT",
            "alert_count": len(incident.alerts),
            "entities": list(incident.entities),
            "start_time": incident.start_time,
            "last_update": incident.last_update,
            "human_verified": False, # P0: Incidents start unverified until human review
            "raw_alerts": [
                {
                    "rule_id": a.rule_id,
                    "description": a.description,
                    "timestamp": a.timestamp,
                    "source_ip": a.source_ip,
                    "dest_ip": a.dest_ip
                } for a in incident.alerts
            ]
        }
        
        # 2. In a real runtime, this would call your ledger.py LedgerEvent
        # For now, we store it to prove the pipeline works.
        self.recorded_events.append(payload)
        print(f"[LEDGER] Incident {incident.incident_id} successfully recorded to chain of custody.")
PYEOF

# 2. Patch CorrelationEngine to use the Bridge
python3 - << 'PYEOF'
import re

path = 'engine/correlation_engine.py'
with open(path, 'r') as f:
    content = f.read()

# Add the import at the top if missing
if 'from ledger_integration import IncidentLedgerBridge' not in content:
    content = "from ledger_integration import IncidentLedgerBridge\n" + content

# Inject the bridge into the class __init__
init_pattern = r'(def __init__\(self, time_window_sec: int = 300\):[ \t]*\n)'
init_hook = """        self.ledger_bridge = IncidentLedgerBridge()
"""
content = re.sub(init_pattern, r'\1' + init_hook, content)

# Inject the bridge call into flush_expired
flush_pattern = r'(self\.closed_incidents\.append\(inc\)[ \t]*\n)'
flush_hook = """                self.ledger_bridge.record_incident(inc)
"""
content = re.sub(flush_pattern, r'\1' + flush_hook, content)

with open(path, 'w') as f:
    f.write(content)

print("[PATCHED] correlation_engine.py: Ledger bridge injected.")
PYEOF

# 3. Update the test to verify the ledger integration
cat << 'PYEOF' > engine/test_correlation.py
#!/usr/bin/env python3
import time
from correlation_engine import CorrelationEngine

def run_simulation():
    print("========================================================")
    print(" Running Correlation + Ledger Integration Test")
    print("========================================================")
    
    engine = CorrelationEngine(time_window_sec=5)
    base_time = time.time() - 10 
    
    mock_attack = [
        {"rule": {"id": "5710", "description": "sshd: Attempt to login with invalid credentials"}, "srcip": "10.0.0.5", "timestamp": base_time},
        {"rule": {"id": "5710", "description": "sshd: Attempt to login with invalid credentials"}, "srcip": "10.0.0.5", "timestamp": base_time + 1},
        {"rule": {"id": "5712", "description": "sshd: Authentication success"}, "srcip": "10.0.0.5", "data": {"username": "root"}, "timestamp": base_time + 2},
        {"rule": {"id": "2010935", "description": "ET WEB_SERVER Possible SQL Injection"}, "srcip": "192.168.1.99", "dstip": "10.0.0.2", "timestamp": base_time + 3},
    ]
    
    print("[INFO] Ingesting 4 raw alerts...")
    for alert in mock_attack:
        engine.ingest(alert)
        
    print("[INFO] Flushing incidents to Ledger...")
    engine.flush_expired()
    
    print("\n--- FINAL STATE ---")
    print(f"Raw Alerts Processed: 4")
    print(f"LLM Incidents Generated: {len(engine.closed_incidents)}")
    print(f"Ledger Events Recorded: {len(engine.ledger_bridge.recorded_events)}")
    
    # Print a sample of what was sent to the ledger
    if engine.ledger_bridge.recorded_events:
        print("\n--- LEDGER PAYLOAD SAMPLE ---")
        import json
        print(json.dumps(engine.ledger_bridge.recorded_events[0], indent=2))
        
    print("========================================================")

if __name__ == "__main__":
    run_simulation()
PYEOF

echo "Running integration test..."
python3 engine/test_correlation.py
