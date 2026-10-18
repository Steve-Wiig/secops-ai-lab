import threading
import time
import random
from rich.console import Console
from rich.live import Live
from rich.table import Table
from rich.panel import Panel
from rich.text import Text

from correlation_engine import CorrelationEngine
from llm_interpreter import LLMInterpreter
from ledger_integration import IncidentLedgerBridge


def generate_mock_alert():
    """Generate a random mock alert dictionary."""
    rule_id = f"rule-{random.randint(1, 10)}"
    description = f"Mock alert {rule_id}"
    timestamp = time.time()
    source_ip = f"10.0.{random.randint(0, 255)}.{random.randint(1, 254)}"
    dest_ip = f"192.168.{random.randint(0, 255)}.{random.randint(1, 254)}"
    file_hash = ''.join(random.choices('0123456789abcdef', k=32))
    username = f"user{random.randint(1, 100)}"
    return {
        "rule": {"id": rule_id, "description": description},
        "timestamp": timestamp,
        "srcip": source_ip,
        "dstip": dest_ip,
        "syscheck": {"md5": file_hash},
        "data": {"username": username}
    }


def build_payload(incident, ledger):
    """Build the incident payload required by LLMInterpreter."""
    # Compute fingerprint using the same logic as ledger_integration._calculate_fingerprint
    rule_ids = sorted(list(set(a.rule_id for a in incident.alerts)))
    entities = sorted(list(incident.entities))
    canonical = f"rules:{'|'.join(rule_ids)}|entities:{'|'.join(entities)}"
    import hashlib
    fingerprint = hashlib.sha256(canonical.encode()).hexdigest()[:16]

    # Retrieve advisory status and occurrence count from ledger recorded events
    advisory_status = "NEW"
    occurrence_count = 1
    for event in ledger.recorded_events:
        if event["incident_id"] == incident.incident_id:
            advisory_status = event["advisory_status"]
            occurrence_count = event["occurrence_count"]
            break

    raw_alerts = [
        {
            "rule_id": a.rule_id,
            "desc": a.description,
            "timestamp": a.timestamp,
            "source_ip": a.source_ip,
            "dest_ip": a.dest_ip
        }
        for a in incident.alerts
    ]

    return {
        "incident_id": incident.incident_id,
        "fingerprint": fingerprint,
        "advisory_status": advisory_status,
        "occurrence_count": occurrence_count,
        "entities": list(incident.entities),
        "raw_alerts": raw_alerts
    }


def background_simulation(engine, ledger, llm, stop_event, paused_flag,
                          processed_ids, pending_decisions, current_incident_id):
    """Background thread that feeds mock alerts and processes closed incidents."""
    while not stop_event.is_set():
        if not paused_flag[0]:
            # Generate and ingest a mock alert
            alert = generate_mock_alert()
            engine.ingest(alert)
            engine.flush_expired()

            # Process newly closed incidents that haven't been analyzed yet
            for inc in engine.closed_incidents:
                if inc.incident_id not in processed_ids:
                    processed_ids.add(inc.incident_id)
                    payload = build_payload(inc, ledger)
                    proposal = llm.analyze(payload)
                    # Pause simulation and store the pending decision
                    paused_flag[0] = True
                    current_incident_id[0] = inc.incident_id
                    pending_decisions[inc.incident_id] = proposal
                    break
        else:
            # Simulation is paused, wait briefly before checking again
            time.sleep(0.1)


def main():
    console = Console()
    engine = CorrelationEngine()
    ledger = IncidentLedgerBridge()
    llm = LLMInterpreter(mock_mode=True)   # Use mock mode for demonstration

    stop_event = threading.Event()
    paused_flag = [False]               # Mutable flag for cross‑thread communication
    processed_ids = set()
    pending_decisions = {}
    current_incident_id = [None]

    # Start background simulation thread
    sim_thread = threading.Thread(
        target=background_simulation,
        args=(engine, ledger, llm, stop_event, paused_flag,
              processed_ids, pending_decisions, current_incident_id)
    )
    sim_thread.start()

    try:
        with Live(console=console, refresh_per_second=4) as live:
            while not stop_event.is_set():
                # Build dashboard tables
                active_table = Table(title="Active Incidents")
                for inc in engine.active_incidents:
                    active_table.add_row(
                        inc.incident_id,
                        str(len(inc.alerts)),
                        ', '.join(sorted(inc.entities))
                    )

                ledger_table = Table(title="Ledger Fingerprints")
                for event in ledger.recorded_events:
                    ledger_table.add_row(
                        event['incident_id'],
                        event['advisory_status'],
                        str(event['occurrence_count'])
                    )

                dashboard = Table.grid()
                dashboard.add_column()
                dashboard.add_column()
                dashboard.add_row(active_table, ledger_table)

                # If simulation is paused, show the pending remediation proposal
                if paused_flag[0] and current_incident_id[0] is not None:
                    proposal = pending_decisions.get(current_incident_id[0])
                    panel = Panel(
                        Text(proposal, style="bold cyan"),
                        title="Remediation Proposal",
                        border_style="blue"
                    )
                    combined = Table.grid()
                    combined.add_column()
                    combined.add_column()
                    combined.add_row(dashboard, panel)
                    live.update(combined)

                    # Human gate: wait for user input
                    user_input = console.input("[A]pprove or [R]eject: ").strip().upper()
                    if user_input == 'A':
                        # Approve: set human_verified=True in the ledger payload
                        for event in ledger.recorded_events:
                            if event['incident_id'] == current_incident_id[0]:
                                event['human_verified'] = True
                                break
                    elif user_input == 'R':
                        # Reject: drop the incident entirely
                        engine.closed_incidents = [
                            inc for inc in engine.closed_incidents
                            if inc.incident_id != current_incident_id[0]
                        ]
                        ledger.recorded_events = [
                            event for event in ledger.recorded_events
                            if event['incident_id'] != current_incident_id[0]
                        ]
                    else:
                        console.print("Invalid input. Please press A or R.")
                        continue

                    # Clear pending decision and resume simulation
                    del pending_decisions[current_incident_id[0]]
                    current_incident_id[0] = None
                    paused_flag[0] = False
                else:
                    live.update(dashboard)

                time.sleep(0.1)
    finally:
        # Ensure the background thread stops
        stop_event.set()
        sim_thread.join()


if __name__ == "__main__":
    main()
