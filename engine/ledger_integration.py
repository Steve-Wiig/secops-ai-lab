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
