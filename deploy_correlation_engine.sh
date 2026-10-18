#!/usr/bin/env bash
set -e

echo "========================================================"
echo " Deploying Tier-1: Deterministic Correlation Engine"
echo "========================================================"

mkdir -p engine

cat << 'PYEOF' > engine/correlation_engine.py
import time
import json
import uuid
from dataclasses import dataclass, field
from typing import List, Dict, Set, Any

@dataclass
class Alert:
    rule_id: str
    description: str
    timestamp: float
    source_ip: str = ""
    dest_ip: str = ""
    file_hash: str = ""
    user: str = ""
    raw_data: Dict[str, Any] = field(default_factory=dict)

@dataclass
class Incident:
    incident_id: str = field(default_factory=lambda: str(uuid.uuid4())[:8])
    alerts: List[Alert] = field(default_factory=list)
    entities: Set[str] = field(default_factory=set)
    start_time: float = 0.0
    last_update: float = 0.0
    
    def add_alert(self, alert: Alert):
        self.alerts.append(alert)
        self.last_update = alert.timestamp
        # Track entities for LLM context enrichment
        for entity in [alert.source_ip, alert.dest_ip, alert.file_hash, alert.user]:
            if entity: self.entities.add(entity)

class CorrelationEngine:
    """
    P0 Deterministic Engine: Groups alerts by shared entities and time windows.
    LLMs interpret the output; they DO NOT decide the grouping.
    """
    def __init__(self, time_window_sec: int = 300):
        self.time_window = time_window_sec
        self.active_incidents: List[Incident] = []
        self.closed_incidents: List[Incident] = []

    def ingest(self, raw_alert: Dict[str, Any]) -> None:
        alert = self._parse_alert(raw_alert)
        
        # 1. Deterministic Grouping: Check for shared entities in active incidents
        target_incident = self._find_matching_incident(alert)
        
        if target_incident:
            target_incident.add_alert(alert)
        else:
            new_inc = Incident(start_time=alert.timestamp, last_update=alert.timestamp)
            new_inc.add_alert(alert)
            self.active_incidents.append(new_inc)

        # 2. Prune & Emit: Move expired incidents to closed queue for Ledger/LLM
        self._flush_expired()

    def _parse_alert(self, data: Dict[str, Any]) -> Alert:
        # Normalizes Wazuh/Suricata JSON into our standard schema
        return Alert(
            rule_id=data.get("rule", {}).get("id", "unknown"),
            description=data.get("rule", {}).get("description", "Unknown Alert"),
            timestamp=data.get("timestamp", time.time()),
            source_ip=data.get("srcip", ""),
            dest_ip=data.get("dstip", ""),
            file_hash=data.get("syscheck", {}).get("md5", ""),
            user=data.get("data", {}).get("username", "")
        )

    def _find_matching_incident(self, alert: Alert) -> Incident:
        alert_entities = {alert.source_ip, alert.dest_ip, alert.file_hash, alert.user}
        alert_entities.discard("")
        
        for incident in self.active_incidents:
            if incident.entities.intersection(alert_entities):
                return incident
        return None

    def _flush_expired(self) -> None:
        now = time.time()
        remaining = []
        for inc in self.active_incidents:
            if now - inc.last_update > self.time_window:
                self.closed_incidents.append(inc)
                print(f"[ENGINE] Incident {inc.incident_id} closed. {len(inc.alerts)} alerts grouped. Entities: {inc.entities}")
                # TODO: Hook into engine/ledger.py to record evidence
            else:
                remaining.append(inc)
        self.active_incidents = remaining

    def get_summary(self) -> Dict[str, int]:
        return {
            "active_incidents": len(self.active_incidents),
            "closed_incidents": len(self.closed_incidents),
            "total_alerts_processed": sum(len(i.alerts) for i in self.active_incidents + self.closed_incidents)
        }
PYEOF

cat << 'PYEOF' > engine/test_correlation.py
#!/usr/bin/env python3
import time
from correlation_engine import CorrelationEngine

def run_simulation():
    print("========================================================")
    print(" Running Correlation Engine Simulation")
    print("========================================================")
    
    # Set a 5-second window for the test (Normally 300s in prod)
    engine = CorrelationEngine(time_window_sec=5)
    
    mock_attack = [
        {"rule": {"id": "5710", "description": "sshd: Attempt to login with invalid credentials"}, "srcip": "10.0.0.5", "timestamp": time.time()},
        {"rule": {"id": "5710", "description": "sshd: Attempt to login with invalid credentials"}, "srcip": "10.0.0.5", "timestamp": time.time() + 1},
        {"rule": {"id": "5712", "description": "sshd: Authentication success"}, "srcip": "10.0.0.5", "data": {"username": "root"}, "timestamp": time.time() + 2},
        # A completely different alert on a different IP (Should form a 2nd Incident)
        {"rule": {"id": "2010935", "description": "ET WEB_SERVER Possible SQL Injection"}, "srcip": "192.168.1.99", "dstip": "10.0.0.2", "timestamp": time.time() + 3},
    ]
    
    print("[INFO] Ingesting 4 raw alerts into the engine...")
    for alert in mock_attack:
        engine.ingest(alert)
        time.sleep(0.1)
        
    print(f"[INFO] Engine Status: {engine.get_summary()}")
    print("[INFO] Waiting for 5-second time window to expire to emit Incidents...")
    time.sleep(6)
    
    # Flush manually to simulate time passing in the test
    engine._flush_expired()
    
    print("\n--- FINAL STATE ---")
    print(f"Raw Alerts Processed: 4")
    print(f"LLM Incidents Generated: {len(engine.closed_incidents)}")
    print("Result: The LLM only needs to analyze 2 Incidents instead of 4 raw alerts.")
    print("========================================================")

if __name__ == "__main__":
    run_simulation()
PYEOF

echo "Files created. Running simulation..."
cd engine && python3 test_correlation.py
