from ledger_integration import IncidentLedgerBridge
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
    """
    def __init__(self, time_window_sec: int = 300):
        self.ledger_bridge = IncidentLedgerBridge()
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

    def _parse_alert(self, data: Dict[str, Any]) -> Alert:
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

    def flush_expired(self) -> None:
        now = time.time()
        remaining = []
        for inc in self.active_incidents:
            if now - inc.last_update > self.time_window:
                self.closed_incidents.append(inc)
                self.ledger_bridge.record_incident(inc)
                print(f"[ENGINE] Incident {inc.incident_id} closed. {len(inc.alerts)} alerts grouped. Entities: {inc.entities}")
            else:
                remaining.append(inc)
        self.active_incidents = remaining

    def get_summary(self) -> Dict[str, int]:
        return {
            "active_incidents": len(self.active_incidents),
            "closed_incidents": len(self.closed_incidents),
            "total_alerts_processed": sum(len(i.alerts) for i in self.active_incidents + self.closed_incidents)
        }
