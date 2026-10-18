# SOC Autopilot Architecture

This document describes the core architectural components of the SOC Autopilot system, focusing on three critical areas: P0 Trust & Safety Invariants, Deterministic Correlation Logic, and Ledger Integration with P1 Advisory Fingerprinting.

## P0 Trust & Safety Invariants

The system enforces a set of non-negotiable invariants to guarantee that AI-generated changes are safe, authorized, and auditable. These invariants are implemented across multiple modules and form the foundation of the platform’s security model.

### Mutation Boundaries
All file-mutation operations (e.g., applying SEARCH/REPLACE patches) are constrained to a well-defined repository root. The function `_p0_mutation_boundary` (in `engine/multi_file_patcher.py`) rejects any target that is a symlink escaping the repository or attempts path traversal outside the allowed base directory. Mutations are only permitted through the guarded `_p0_safe_open` helper, which ensures that write/append operations never touch protected paths.

### Human Gates
Before any state-changing event is recorded in the immutable ledger, a human-verified flag must be set. The `LedgerEvent` dataclass (in `engine/ledger.py`) enforces this via `_p0_human_gate`, which raises an exception if `human_verified` is `False`. This gate sits below the authorization boundary, meaning even an authorized caller cannot bypass the requirement for explicit human approval.

### Fail-Closed Design
Every external dependency—LLM inference, file patching, database access—is designed to fail loudly rather than silently degrade. In `engine/llm_interpreter.py`, any network error, timeout, or HTTP failure triggers an `InferenceFailed` exception, halting the pipeline. Similarly, `apply_multi_file_patches` raises a `ValueError` if the exact search text is not found, preventing partial or incorrect patches. This ensures that the system never proceeds with unverified data.

Additionally, the `assert_not_protected` function (from `engine/protected_kernel.py`) acts as a final guard: even if a file is explicitly authorized, mutations to safety-critical files are refused.

## Deterministic Correlation Logic

Alert correlation is performed deterministically, without relying on probabilistic heuristics. The `CorrelationEngine` class (in `engine/correlation_engine.py`) groups incoming alerts into incidents based on shared entities and a configurable time window.

### Alert Ingestion
The `ingest` method receives a raw alert dictionary, parses it into an `Alert` object, and immediately attempts to match it against existing active incidents.

### Incident Matching
Matching is done by computing the intersection of entity sets (source IP, destination IP, file hash, username). If any entity overlaps with an active incident, the alert is appended to that incident. Otherwise, a new `Incident` is created with the current timestamp as both `start_time` and `last_update`.

### Time-Window Expiry
Incidents are periodically flushed by `flush_expired`. When the elapsed time since `last_update` exceeds `time_window_sec` (default 300 seconds), the incident is moved to the closed list, recorded in the ledger, and printed for operator visibility. This guarantees that transient noise does not accumulate indefinitely.

The logic is fully deterministic: given the same sequence of alerts and the same time window, the resulting incidents are identical across runs.

## Ledger Integration & P1 Advisory Fingerprinting

Once an incident is closed, it is handed to the `IncidentLedgerBridge` (in `engine/ledger_integration.py`) for persistent recording. The bridge implements P1 Advisory Fingerprinting to deduplicate recurring advisories.

### Fingerprint Calculation
For each closed incident, a fingerprint is computed from the sorted list of distinct rule IDs and the sorted set of entities. The fingerprint is a SHA-256 hash truncated to 16 characters, producing a compact, collision-resistant identifier.

### Deduplication
The bridge maintains an in-memory cache (`seen_fingerprints`) of previously recorded fingerprints. When a new incident arrives:
- If the fingerprint matches an existing entry, the `advisory_status` is set to `"RECURRING"` and the occurrence count is incremented.
- Otherwise, the status is set to `"NEW"` and the count starts at 1.

Each recorded event includes the fingerprint, advisory status, occurrence count, and the full list of raw alerts. This allows downstream consumers to detect repeated attacks and prioritize remediation.

The ledger itself (`engine/ledger.py`) provides strict parsing and validation of these events, rejecting malformed or future-incompatible schemas. The `_p0_require_human_verified` function ensures that every mutation to the ledger’s state is preceded by human confirmation.

## Summary

These three pillars work together to create a system where:
- AI-generated changes are bounded, authorized, and human-reviewed.
- Alerts are correlated deterministically into meaningful incidents.
- Recurring threats are identified and tracked through a deduplicated ledger.

Together, they enable a secure, autonomous SOC pipeline that can operate without manual intervention while maintaining rigorous safety guarantees.
