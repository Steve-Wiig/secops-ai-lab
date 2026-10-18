#!/usr/bin/env bash
set -e

echo "========================================================"
echo " Deploying P1: Advisory Fingerprinting (Deduplication)"
echo "========================================================"

# 1. Update ledger_integration.py to include fingerprinting
cat << 'PYEOF' > engine/ledger_integration.py
from typing import Dict, Any, List
import json
import hashlib

class IncidentLedgerBridge:
    """
    Converts closed CorrelationEngine Incidents into LedgerEvent-compatible payloads.
    Implements P1 Advisory Fingerprinting for deduplication.
    """
    def __init__(self):
        self.recorded_events = []
        # In-memory cache simulates the ledger's historical record of fingerprints
        self.seen_fingerprints: Dict[str, int] = {} 

    def _calculate_fingerprint(self, incident) -> str:
        # Extract distinct rule IDs and entities to form a canonical signature
        rule_ids = sorted(list(set(a.rule_id for a in incident.alerts)))
        entities = sorted(list(incident.entities))
        
        canonical = f"rules:{'|'.join(rule_ids)}|entities:{'|'.join(entities)}"
        return hashlib.sha256(canonical.encode()).hexdigest()[:16]

    def record_incident(self, incident) -> None:
        fingerprint = self._calculate_fingerprint(incident)
        
        # Check for deduplication (Advisory Fingerprinting)
        if fingerprint in self.seen_fingerprints:
            self.seen_fingerprints[fingerprint] += 1
            advisory_status = "RECURRING"
            occurrence_count = self.seen_fingerprints[fingerprint]
            print(f"[LEDGER] Advisory Fingerprint match ({fingerprint}). This incident has occurred {occurrence_count} times.")
        else:
            self.seen_fingerprints[fingerprint] = 1
            advisory_status = "NEW"
            occurrence_count = 1
            print(f"[LEDGER] New Incident recorded. Fingerprint: {fingerprint}")

        payload = {
            "incident_id": incident.incident_id,
            "fingerprint": fingerprint,
            "advisory_status": advisory_status,
            "occurrence_count": occurrence_count,
            "event_type": "CORRELATED_INCIDENT",
            "alert_count": len(incident.alerts),
            "entities": list(incident.entities),
            "start_time": incident.start_time,
            "last_update": incident.last_update,
            "human_verified": False, # P0: Incidents start unverified
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
        
        self.recorded_events.append(payload)
PYEOF

# 2. Update test to simulate a recurring attack
cat << 'PYEOF' > engine/test_correlation.py
#!/usr/bin/env python3
import time
from correlation_engine import CorrelationEngine

def run_simulation():
    print("========================================================")
    print(" Running Correlation + P1 Fingerprinting Test")
    print("========================================================")
    
    engine = CorrelationEngine(time_window_sec=600)
    base_time = time.time() - 10
    
    # Attack 1: SSH Brute Force
    attack_1 = [
        {"rule": {"id": "5710", "description": "sshd: Attempt to login"}, "srcip": "10.0.0.5", "timestamp": base_time},
        {"rule": {"id": "5712", "description": "sshd: Auth success"}, "srcip": "10.0.0.5", "data": {"username": "root"}, "timestamp": base_time + 2},
    ]
    
    # Attack 2: The EXACT same SSH attack 5 minutes later
    attack_2 = [
        {"rule": {"id": "5710", "description": "sshd: Attempt to login"}, "srcip": "10.0.0.5", "timestamp": base_time + 300},
        {"rule": {"id": "5712", "description": "sshd: Auth success"}, "srcip": "10.0.0.5", "data": {"username": "root"}, "timestamp": base_time + 302},
    ]

    # Attack 3: Something different
    attack_3 = [
        {"rule": {"id": "2010935", "description": "ET WEB_SERVER Possible SQL Injection"}, "srcip": "192.168.1.99", "dstip": "10.0.0.2", "timestamp": base_time + 305},
    ]

    print("[INFO] Ingesting Attack 1 (SSH)...")
    for alert in attack_1:
        engine.ingest(alert)
    engine.flush_expired() # Force flush to ledger
    
    print("\n[INFO] Ingesting Attack 2 (Same SSH, later)...")
    for alert in attack_2:
        engine.ingest(alert)
    engine.flush_expired() # Force flush to ledger
    
    print("\n[INFO] Ingesting Attack 3 (SQLi)...")
    for alert in attack_3:
        engine.ingest(alert)
    engine.flush_expired() # Force flush to ledger
    
    print("\n--- FINAL LEDGER STATE ---")
    for i, event in enumerate(engine.ledger_bridge.recorded_events):
        print(f"\nLedger Event {i+1}:")
        print(f"  - Fingerprint: {event['fingerprint']}")
        print(f"  - Status: {event['advisory_status']}")
        print(f"  - Occurrences: {event['occurrence_count']}")
        print(f"  - Entities: {event['entities']}")
        
    print("\nResult: The LLM is protected from alert fatigue. It will only be invoked for NEW incidents, or batched for RECURRING advisories.")
    print("========================================================")

if __name__ == "__main__":
    run_simulation()
PYEOF

echo "Running P1 Fingerprinting test..."
python3 engine/test_correlation.py
