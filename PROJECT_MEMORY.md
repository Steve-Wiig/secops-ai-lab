
## 🛡️ THE QUALITY GATE (Autonomous Guardrails)
- **Location:** `tools/quality_gate.py`
- **Enforcement:** Runs automatically on every `git commit` via `.git/hooks/pre-commit`.
- **Rules:** Scans all `.py` files for P0 (silent failures, sync-in-async) and P1 (missing timeouts) anti-patterns.
- **Aider Directive:** If Aider writes code that fails the Quality Gate, it MUST fix the P0/P1 issues before attempting to commit again. Aider can also propose new regex patterns to add to `tools/quality_gate.py` if it discovers new systemic risks.
