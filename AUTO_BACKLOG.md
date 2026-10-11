# 🤖 Autonomous Backlog
*Generated: 2026-10-11T17:01:28*

## Instructions for Aider
- Pick the **top unchecked** item below
- Investigate root cause using available context
- Apply minimal surgical fix
- Run `python3 tools/quality_gate.py` and relevant tests
- Change `[ ]` to `[x]` when resolved
- If unfixable, add to `dashboard_memory.db` fix_patterns and skip

## 🔴 Prioritized Issues (435 found)

- [x] **🔴 Test Regression** *(resolved: stale finding — no lambda exists in current code)*
  - Message: `[pi_edge_bandit] engine/writeback/so_cases.py: [PYLINT E1121] Consider refactoring the lambda function to pass fewer arguments.`
  - Source: `engine/writeback/so_cases.py`

- [x] **🔴 Test Regression**
  - Message: `[unknown] engine/memory_store.py: load_records reads entire file *(resolved)* into memory. For large JSONL files (GBs), this causes OOM errors. Both append_unique and find_matching call load_records.`
  - Source: `engine/memory_store.py`

- [x] **🔴 Test Regression**
  - Message: `[unknown] engine/memory_store.py: append_unique recomputes fingerprint *(resolved)* for every existing record on each append (O(n) per append). Records already have memory_hash field - should compare against that instead.`
  - Source: `engine/memory_store.py`

- [x] **🔴 Test Regression**
  - Message: `[unknown] engine/multi_file_patcher.py: The `_find_patch_location_strict` function contains `time.sleep(0.1)` inside a while loop that iterates over all exact matches. For a file with many occurrences of a search term, this causes massive l`
  - Source: `engine/multi_file_patcher.py`

- [x] **🔴 Test Regression**
  - Message: `[unknown] engine/patch_parser.py: Fuzzy matching creates a new SequenceMatcher *(resolved: SequenceMatcher reuse)* instance for every window position, resulting in O(n*m) object allocations where n=source lines and m=search lines. For a 1000-line file with 10-line searc`
  - Source: `engine/patch_parser.py`

- [x] **🔴 Test Regression**
  - Message: `[unknown] engine/queue_priority.py: Priority mapping logic is duplicated in three places: NUMERIC_SEVERITY_PRIORITY dict (lines 15-25), severity_to_priority function (lines 72-80), and priority_case_sql function (lines 125-131). Any cha`
  - Source: `engine/queue_priority.py`

- [x] **🔴 Test Regression** *(skipped: auto-fix failed)*
  - Message: `[unknown] engine/telemetry.py: _enforce_cap uses O(N^2) algorithm: while loop calls _get_total_size() which iterates entire outbox_dir on each iteration; with many files this causes severe I/O blocking`
  - Source: `engine/telemetry.py`

- [x] **🔴 Test Regression** *(skipped: auto-fix failed)*
  - Message: `[unknown] memory/retention.py: Dead code: _archive_partition_worker function is defined but never called; execute_archive_plan uses its own inline wrapper`
  - Source: `memory/retention.py`

- [ ] **🔴 Test Regression**
  - Message: `[unknown] overnight/pi_idle_reviewer.py: Unbounded memory usage: entire PATCHES_FILE read into memory as list of tuples; large files cause OOM`
  - Source: `overnight/pi_idle_reviewer.py`

- [ ] **🔴 Test Regression**
  - Message: `[unknown] tools/changelog_completeness_check.py: Module-level functions (get_latest_tag, iter_commits_since_tag, get_commits_since_tag, parse_changelog_hashes) duplicate GitRepo and ChangelogParser class methods for 'backward compatibility with test`
  - Source: `tools/changelog_completeness_check.py`

- [ ] **🔴 Test Regression**
  - Message: `[unknown] tools/changelog_completeness_check.py: main() function is 100 lines with 5 nested functions, mixing argument parsing, validation, collection, parsing, comparison, and reporting; violates single responsibility`
  - Source: `tools/changelog_completeness_check.py`

- [ ] **🔴 Test Regression**
  - Message: `[unknown] overnight/self_improver.py: File is 2518 lines with 50+ functions, multiple global variables, and mixed responsibilities (queue management, fix generation, TDD, forensic analysis, proven/failed memory, scorecard, CLI). Violates `
  - Source: `overnight/self_improver.py`

- [ ] **🔴 Test Regression**
  - Message: `[pi_edge_bandit] main.py: [BANDIT Non-exclusive include/exclude test sets: {'B101'}] Ensure the test set is exclusively included or excluded.`
  - Source: `main.py`

- [ ] **🟡 Overnight Exception**
  - Message: `paths, safety-gate logic, and queue-transition semantics in provided codebase.`
  - Source: `llm_analysis_20261010_020915.md`

- [ ] **🟡 Overnight Exception**
  - Message: `as env_err:` around `EventEnvelope(**raw_dict)`. Invalid JSON or schema drift causes immediate `INVALID_ENVELOPE` failure and queue transition. | **~5%**<br>*Quinary driver: Payload corruption or vers`
  - Source: `llm_analysis_20261010_020915.md`

- [ ] **🟡 Overnight Exception**
  - Message: `unwinds the entire job (`RuntimeError` in the outer scope). This design assumes thread safety and lease liveness are orthogonal, but in practice, a slow inference call or`
  - Source: `llm_analysis_20261010_020915.md`

- [ ] **🟡 Overnight Exception**
  - Message: `Swallowing Downstream** | `read_cache()` catches `(OSError, ValueError, KeyError, TypeError)` and returns `None` silently. | AI cannot diagnose *why* the cache is stale/missing; it always falls back t`
  - Source: `llm_analysis_20261010_020628.md`

- [ ] **🟡 Overnight Exception**
  - Message: `failures.`
  - Source: `llm_analysis_20261010_015431.md`

- [ ] **🟡 Overnight Exception**
  - Message: `` in `_encode_internal``
  - Source: `llm_analysis_20261010_014725.md`

- [ ] **🟡 Overnight Exception**
  - Message: `Masking** | `except Exception` in `worker()` (line 41) with `results.append(None)`. The `broad-except` pylint disable comment admits the anti-pattern but leaves it unremediated. | AI agents often "fix`
  - Source: `llm_analysis_20261010_014149.md`

- [ ] **🟡 Overnight Exception**
  - Message: `pass` in `worker()` masks race-induced crashes, causing silent truncation. |`
  - Source: `llm_analysis_20261010_013653.md`

- [ ] **🟡 Overnight Exception**
  - Message: `Masking** | `except Exception:  # pylint: disable=broad-except` in `worker()` silently swallows any hash-generation or append error. From an AI’s perspective, “no error raised” = “success,” obscuring `
  - Source: `llm_analysis_20261010_013653.md`

- [ ] **🟡 Overnight Exception**
  - Message: `Masking with Structured Error Propagation`
  - Source: `llm_analysis_20261010_013653.md`

- [ ] **🟡 Overnight Exception**
  - Message: `pass` in `worker()`. Instead, define a custom `HashChainAppendError` exception hierarchy (`RaceConditionError`, `GenerationError`). Have `worker()` raise (not catch), and let the caller decide whether`
  - Source: `llm_analysis_20261010_013653.md`

- [ ] **🟡 Overnight Exception**
  - Message: `catching `(urllib.error.URLError, json.JSONDecodeError, TimeoutError, socket.timeout)` but also `except (urllib.error.URLError, json.JSONDecodeError, TimeoutError, socket.timeout) as e:` - note `Timeo`
  - Source: `llm_analysis_20261010_013316.md`

- [ ] **🟡 Overnight Exception**
  - Message: `Safety** - `_validate` raises `RuntimeError` uncaught in `main`; broad exception catches; service validation failure crashes the gate.`
  - Source: `llm_analysis_20261010_013316.md`

- [ ] **🟡 Overnight Exception**
  - Message: `handling that swallows real errors, and the idempotency check logic that's correct but fragile.`
  - Source: `llm_analysis_20261010_013316.md`

- [ ] **🟡 Overnight Exception**
  - Message: `Safety / Unhandled Crashes** - `_validate` raises `RuntimeError` without try/except in `main`; `validate_against_service` has backoff but still may fail; broad exception catches. Count: 3 failures.`
  - Source: `llm_analysis_20261010_013316.md`

- [ ] **🟡 Overnight Exception**
  - Message: `would crash pytest.`
  - Source: `llm_analysis_20261010_013316.md`

- [ ] **🟡 Overnight Exception**
  - Message: `types; broad `except` clauses.`
  - Source: `llm_analysis_20261010_013316.md`

- [ ] **🟡 Overnight Exception**
  - Message: `Safety / Unhandled Crashes | 3 | Pytest (uncaught RuntimeError crashes suite)`
  - Source: `llm_analysis_20261010_013316.md`

- [ ] **🟡 Overnight Exception**
  - Message: `Masking** | 6 | 20% | `validate_against_service` catches `(URLError, JSONDecodeError, TimeoutError, socket.timeout)` and returns `True` on failure. AST-import gates reject the module for "swallowing s`
  - Source: `llm_analysis_20261010_013009.md`

- [ ] **🟡 Overnight Error**
  - Message: `unsupported partial triage_queue migration`. | **~25%** |`
  - Source: `llm_analysis_20261010_021123.md`

- [ ] **🟠 Safety Gate Logic**
  - Message: `safety-gate`
  - Source: `llm_analysis_20261010_021123.md`

- [ ] **🟠 Safety Gate Logic**
  - Message: `Safety Gate`
  - Source: `llm_analysis_20261010_021123.md`

- [ ] **🟡 Overnight Error**
  - Message: `outside the inference try/finally. | **~24%**<br>*Secondary driver: Threaded lease heartbeat races and 30s hard timeout under queue pressure.* |`
  - Source: `llm_analysis_20261010_020915.md`

- [ ] **🟠 Safety Gate Logic**
  - Message: `queue-transition`
  - Source: `llm_analysis_20261010_020915.md`

- [ ] **🟠 Safety Gate Logic**
  - Message: `queue transition`
  - Source: `llm_analysis_20261010_020915.md`

- [ ] **🟡 Overnight Error**
  - Message: `(masking data loss) or crashes the pipeline. |`
  - Source: `llm_analysis_20261010_020628.md`

- [ ] **🟡 Overnight Error**
  - Message: `object instead of raising `RuntimeError`. | **-20% reduction** in API Contract Drift + Fragile Filtering failures. The AI encounters consistent, predictable data shapes. When the API changes, the vali`
  - Source: `llm_analysis_20261010_020628.md`

- [ ] **🟡 Overnight Error**
  - Message: `propagation`
  - Source: `llm_analysis_20261010_020339.md`

- [ ] **🟡 Overnight Error**
  - Message: `paths from `_handle_connection`, cross-referenced with safety gate outcomes (AST, Pytest, Truncation) and typical AI-agent interaction logs from the overnight run.`
  - Source: `llm_analysis_20261010_020042.md`

- [ ] **🟡 Overnight Error**
  - Message: `return paths. Grouping these by root cause and typical AI-agent frequency yields 5 distinct failure classes. Successes constitute the remaining ~45% of the run.`
  - Source: `llm_analysis_20261010_020042.md`

- [ ] **🟡 Overnight Error**
  - Message: `Paths (Code) | Estimated Rejection Share | Primary AI Failure Mode |`
  - Source: `llm_analysis_20261010_020042.md`

- [ ] **🟡 Overnight Error**
  - Message: `database is locked` (especially under concurrent Pytest runs). | **6** | Pytest (test isolation/teardown) |`
  - Source: `llm_analysis_20261010_015231.md`

- [ ] **🟡 Overnight Error**
  - Message: `loops |`
  - Source: `llm_analysis_20261010_014725.md`

- [ ] **🟡 Overnight Error**
  - Message: `Paths** | `raise RuntimeError(f"Library code called exit(1)")` in `_encode_internal` (line 54) | AI may generate code paths that intentionally or accidentally trigger this string, causing hard-failure`
  - Source: `llm_analysis_20261010_014725.md`

- [ ] **🟡 Overnight Error**
  - Message: `raise` in `__init__` (line 39) wraps a `ValueError` into `RuntimeError` with no added context; bare `except Exception:` in `_encode_internal``
  - Source: `llm_analysis_20261010_014725.md`

- [ ] **🟡 Overnight Error**
  - Message: `messages are generic `CONFIG ERROR` with no remediation hint. Absent the env var, the default (90% of total) assumes a single‑GPU context. | 5 | 12.5% |`
  - Source: `llm_analysis_20261010_014510.md`

- [ ] **🟡 Overnight Error**
  - Message: `codes (e.g., `ERR_BUDGET_OUT_OF_RANGE`, `ERR_UNIT_MISMATCH`). Decouple default‑ratio logic from the 90% hard‑code. | Eliminates Category F4. Gives the AI clear, machine‑readable error payloads it can `
  - Source: `llm_analysis_20261010_014510.md`

- [ ] **🟡 Overnight Error**
  - Message: `propagation semantics and triggers AST/lint gates or causes uncaught exceptions in ThreadPoolExecutor. |`
  - Source: `llm_analysis_20261010_014149.md`

- [ ] **🟡 Overnight Error**
  - Message: `raised” = “success,” obscuring the very race conditions the stress test is designed to expose. | False-positive passes; deferred fixes for human review. |`
  - Source: `llm_analysis_20261010_013653.md`

- [ ] **🟡 Overnight Error**
  - Message: `handling, etc.`
  - Source: `llm_analysis_20261010_013316.md`

- [ ] **🟡 Overnight Error**
  - Message: `Handling / Exception Safety** - `_validate` raises `RuntimeError` uncaught in `main`; broad exception catches; service validation failure crashes the gate.`
  - Source: `llm_analysis_20261010_013316.md`

- [ ] **🟡 Overnight Error**
  - Message: `rates.`
  - Source: `llm_analysis_20261010_013316.md`

- [ ] **🟡 Overnight Error**
  - Message: `in main, the tight coupling of test case generation to prefix names, the broad exception handling that swallows real errors, and the idempotency check logic that's correct but fragile.`
  - Source: `llm_analysis_20261010_013316.md`

- [ ] **🟡 Overnight Error**
  - Message: `Handling Gaps** (3 items) - `_validate` raises uncaught; `validate_against_service` exception types; broad `except` clauses.`
  - Source: `llm_analysis_20261010_013316.md`

- [ ] **🟡 Overnight Error**
  - Message: `crashes suite)`
  - Source: `llm_analysis_20261010_013316.md`

- [ ] **🟡 Overnight Error**
  - Message: `(C2) cascades into signature mismatch (C1) and binding failure (C4). C5 is largely a downstream build-infrastructure issue.`
  - Source: `llm_analysis_20261010_012701.md`

- [ ] **🟡 Overnight Error**
  - Message: `triggers a cryptographic failure that is opaque to high-level code edits. |`
  - Source: `llm_analysis_20261010_012701.md`

- [ ] **🟡 Overnight Error**
  - Message: `classes, and functions that likely generate failures. The user might be expecting me to infer failure patterns from the code's design, or perhaps there's an implicit dataset embedded in the prompt's c`
  - Source: `llm_analysis_20261010_012402.md`

- [ ] **🟡 Overnight Error**
  - Message: `messages that hint at failure modes: `MAX_LINES_CHANGED_PER_PATCH_SET = 500`, `FUZZY_SIMILARITY_THRESHOLD = 0.85`, error classes `PatchParseError`, `PatchApplyError`, `ScopeBudgetExceededError`, messa`
  - Source: `llm_analysis_20261010_012402.md`

- [ ] **🟡 Overnight Error**
  - Message: `types and scenarios described in the code. I need to extract failure categories from the code's logic and error handling.`
  - Source: `llm_analysis_20261010_012402.md`

- [ ] **🟡 Overnight Error**
  - Message: `handling, patch parsing logic, and the described constraints.`
  - Source: `llm_analysis_20261010_012402.md`

- [ ] **🟡 Overnight Error**
  - Message: `types from the code, mapped to meaningful categories for an AI coding agent running on a SOC/SIEM pipeline.`
  - Source: `llm_analysis_20261010_012402.md`

- [ ] **🟡 Overnight Error**
  - Message: `I need 3-5 categories. I'll group them:`
  - Source: `llm_analysis_20261010_012402.md`

- [ ] **🟡 Overnight Error**
  - Message: `types as the primary data, map them to categories that an AI agent would encounter, and provide counts based on the ~45% success rate. I'll assume a total of, say, 40 patch attempts overnight (reasona`
  - Source: `llm_analysis_20261010_012402.md`

- [ ] **🟡 Overnight Error**
  - Message: `sources, and assign estimated proportions/frequencies:`
  - Source: `llm_analysis_20261010_012402.md`

- [ ] **🟡 Overnight Error**
  - Message: `messages, and treat those as the "data". I'll proceed with that interpretation: the failure patterns are inherent in the module's design and error handling.`
  - Source: `llm_analysis_20261010_012402.md`

- [ ] **🟡 Overnight Error**
  - Message: `unterminated blocks, empty blocks, no blocks found)`
  - Source: `llm_analysis_20261010_012402.md`

- [ ] **🟡 Overnight Error**
  - Message: `exact/fuzzy below threshold)`
  - Source: `llm_analysis_20261010_012402.md`

- [ ] **🟡 Overnight Error**
  - Message: `>500 lines changed)`
  - Source: `llm_analysis_20261010_012402.md`

- [ ] **🟡 Overnight Error**
  - Message: `overlapping resolved blocks)`
  - Source: `llm_analysis_20261010_012402.md`

- [ ] **🟡 Overnight Error**
  - Message: `classes are: PatchParseError, PatchApplyError, ScopeBudgetExceededError. Sub-reasons within PatchApplyError: "SEARCH block not found (Exact & Fuzzy < threshold)", "Overlapping patches detected". Withi`
  - Source: `llm_analysis_20261010_012402.md`

- [ ] **🟡 Overnight Error**
  - Message: `fuzzy/thresh)`
  - Source: `llm_analysis_20261010_012402.md`

- [ ] **🟡 Overnight Error**
  - Message: `overlap)`
  - Source: `llm_analysis_20261010_012402.md`

- [ ] **🟡 Overnight Error**
  - Message: `messages. I'll proceed by extracting failure categories from the module's logic, assigning estimated frequencies based on the ~45% success rate, and identifying architectural debt from the code's desi`
  - Source: `llm_analysis_20261010_012402.md`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/autopilot_runner.py: _report_simulation_result accepts ctx: Any instead of a proper typed protocol or InvestigationContext. This prevents static analysis, IDE support, and makes refactoring risky.`
  - Source: `engine/autopilot_runner.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/autopilot_runner.py: _report_investigation_outcome accepts ctx: Any instead of proper type. Same issue as above - loses type safety and IDE support.`
  - Source: `engine/autopilot_runner.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/autopilot_stress_test.py: The process_burst function mixes data generation, pipeline execution, and output formatting (print statements). This reduces reusability, testability, and violates separation of concerns.`
  - Source: `engine/autopilot_stress_test.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/canonical_envelope.py: Missing validators for hash fields and payload sanitization claim. The comment states payload is 'strictly sanitized' but no validation enforces this, creating a documentation/code gap.`
  - Source: `engine/canonical_envelope.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/deterministic_policy.py: Unused **kwargs parameter in evaluate_deterministic_policy. Accepts arbitrary keyword arguments but discards them, hiding caller errors and confusing API consumers.`
  - Source: `engine/deterministic_policy.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/deterministic_policy.py: PolicyRecommendationEnvelope duplicates 14 fields across legacy/new naming with complex validator. This technical debt increases cognitive load, bug surface, and migration risk.`
  - Source: `engine/deterministic_policy.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/development_budget_broker.py: _handle_connection is 78 lines and handles reading, parsing, validation, authorization, budget reservation, and response. Violates single responsibility; hard to test and maintain.`
  - Source: `engine/development_budget_broker.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/development_candidate.py: verify_diff_integrity re-computes SHA-256 on every call. For large diffs or frequent verification (e.g., in pipeline loops), this causes redundant CPU allocation. No caching of verification result for`
  - Source: `engine/development_candidate.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/development_candidate.py: created_at uses datetime.now(timezone.utc).isoformat() which produces variable output: microseconds included only if non-zero, timezone as +00:00. Cross-system serialization/deserialization may yield `
  - Source: `engine/development_candidate.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/development_orchestrator.py: Function has 9 parameters (7 positional/keyword), violating single responsibility and making testing difficult. Parameters safety_ok, regression_ok, safety_reason, regression_reason are gate results t`
  - Source: `engine/development_orchestrator.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/development_worker_dispatch.py: The explicit_cloud check uses startswith(('openrouter/', 'gemini/')) which is hardcoded and will require code changes when new cloud providers are added`
  - Source: `engine/development_worker_dispatch.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/development_worker_gate.py: key_registry parameter typed as Optional[object] is too generic. Provides no type safety or IDE support for registry interface.`
  - Source: `engine/development_worker_gate.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/development_worker_pipeline.py: Significant code duplication between `evaluate_worker_proposal` and `evaluate_strict_proposal`: both call `_collect_hard_veto_reasons`, invoke a quorum function, and construct `WorkerApprovalResult` i`
  - Source: `engine/development_worker_pipeline.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/git_isolation.py: Hardcoded '.worktrees' directory name reduces flexibility. Cannot configure worktree location for different environments or policies.`
  - Source: `engine/git_isolation.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/hash_chain_sealer.py: insert_chain_links uses execute_values without specifying page_size. Default is 100, causing many round-trips for large batches (DEFAULT_BATCH_SIZE=10000).`
  - Source: `engine/hash_chain_sealer.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/hash_chain_sealer.py: _STANDARD_ATTRS hardcodes LogRecord attributes. New Python versions may add attributes (e.g., taskName in 3.12), causing them to be treated as 'extra' fields and duplicated in JSON output.`
  - Source: `engine/hash_chain_sealer.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/intake_eve.py: process_eve_file accumulates all rows in memory (rows list) before bulk insert; large EVE files (GBs) will cause memory exhaustion`
  - Source: `engine/intake_eve.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/intake_eve.py: Three decorators (with_db, execute_in_transaction, execute_with_connection) have overlapping functionality and duplicated error handling logic`
  - Source: `engine/intake_eve.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/intake_wazuh.py: payload_json computed once but used twice in INSERT (for payload and payload_ref columns). Not a performance issue per se, but if payload_ref is meant to be a reference (hash/pointer), duplicating ful`
  - Source: `engine/intake_wazuh.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/intake_wazuh.py: Module-level global _connection variable makes testing difficult (state persists between tests) and prevents concurrent use with different databases. Violates dependency injection principles.`
  - Source: `engine/intake_wazuh.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/intake_wazuh.py: logging.basicConfig called in _load_config modifies root logger globally. If this module is imported by another application, it hijacks logging configuration. Library code should not configure root lo`
  - Source: `engine/intake_wazuh.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/investigation_controller.py: Mock LLM logic (`_generate_mock_llm_proposal`) is embedded in production code with hardcoded rule ID '5710' and action mappings. This prevents unit testing with different LLM behaviors and complicates`
  - Source: `engine/investigation_controller.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/investigation_controller.py: Magic strings for tool names, rule IDs, action types, and default targets scattered in mock LLM logic`
  - Source: `engine/investigation_controller.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/ioc_extractor.py: `__main__` block calls `extract_iocs({})` which attempts a real DB connection and will crash in environments without database; unsuitable for smoke testing or module validation`
  - Source: `engine/ioc_extractor.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/ioc_extractor.py: Recursive text extraction without visited-set tracking re-processes shared sub-objects multiple times, causing O(n^2) behavior on DAG-shaped alert payloads`
  - Source: `engine/ioc_extractor.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/ioc_extractor.py: deduplicate_iocs() calls datetime.now(timezone.utc) once but the timestamp represents extraction start, not per-IOC first_seen. All IOCs get identical timestamp even if extracted at different times.`
  - Source: `engine/ioc_extractor.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/ioc_extractor.py: _extract_alert_text_fields() has hardcoded _ALERT_TEXT_FIELDS set and _MAX_RECURSION_DEPTH. Not configurable for different alert schemas or nesting requirements.`
  - Source: `engine/ioc_extractor.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/memory_store.py: append_unique loads all existing records and computes fingerprint for each on every call. O(n) per append with repeated hashing. Becomes quadratic for batch inserts.`
  - Source: `engine/memory_store.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/memory_store.py: find_matching loads all records into memory before filtering. For large files, this is wasteful when only a few matches are needed (limit=5 default).`
  - Source: `engine/memory_store.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/memory_store.py: record_fingerprint uses hardcoded key list. Adding new identity-relevant fields requires modifying this function. No extensibility for callers with different schemas.`
  - Source: `engine/memory_store.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/memory_store.py: append_record doesn't add memory_hash *(resolved)* field, unlike append_unique. Inconsistent schema makes downstream queries harder (some records have hash, some don't).`
  - Source: `engine/memory_store.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/memory_store.py: No size limits or rotation for JSONL files. Unbounded growth leads to disk exhaustion and degraded read performance over time.`
  - Source: `engine/memory_store.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/model_registry.py: get_default_router() contains hardcoded URLs and a specific private IP address (192.168.1.19). This prevents deployment flexibility and leaks infrastructure details into source code.`
  - Source: `engine/model_registry.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/multi_file_patcher.py: _find_patch_location_strict function is defined but never called anywhere in the module. Dead code increases maintenance burden and confusion`
  - Source: `engine/multi_file_patcher.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/multi_file_patcher.py: Exact match finding uses a while loop with find() and sleep, which is O(n*m) with artificial delay. For large files this is extremely slow`
  - Source: `engine/multi_file_patcher.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/multi_file_patcher.py: The module docstring claims 'LENIENT FUZZY MATCHING' and 'IMPROVEMENT #13: normalize indentation + variable window' but the implementation in `apply_multi_file_patches` uses strict exact matching only`
  - Source: `engine/multi_file_patcher.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/multi_file_patcher.py: O(n^2) exact match search algorithm: calling find() in a loop with incrementing start position is inefficient for large texts`
  - Source: `engine/multi_file_patcher.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/openrouter_catalog.py: Bare `except Exception:` in `validate_openrouter_model_allowed` swallows all errors (network, parsing, auth) without logging, making debugging impossible`
  - Source: `engine/openrouter_catalog.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/patch_parser.py: _find_fuzzy_match creates a new SequenceMatcher *(resolved: SequenceMatcher reuse)* and joins strings for every window position (O(n) allocations). For a 10000-line file and 50-line search, this creates 9950 SequenceMatcher objects and `
  - Source: `engine/patch_parser.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/path_utils.py: Implementation is fragile to refactoring and provides no fallback. A marker-based search is more robust and self-documenting.`
  - Source: `engine/path_utils.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/queue_manager.py: `reap_stale_jobs` fetches all stale jobs then processes each in a loop with individual `transition_queue_state` calls and UPDATEs. N+1 pattern; slow for many stale jobs.`
  - Source: `engine/queue_manager.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/queue_manager.py: `ensure_queue_schema` is 50+ lines handling column additions, data backfills, table creation, and index management. Violates single responsibility; hard to test and review.`
  - Source: `engine/queue_manager.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/queue_priority.py: NUMERIC_SEVERITY_PRIORITY dict is explicitly documented as not used by the code ('does not look values up in this dict directly') but must stay in sync. This is an anti-pattern that guarantees drift o`
  - Source: `engine/queue_priority.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/quota_ledger.py: Missing index on quota_ledger.last_reset_date. Daily rollover queries scan all rows when checking/resetting daily counters.`
  - Source: `engine/quota_ledger.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/quota_ledger.py: record_usage uses SELECT then UPDATE then INSERT (3 round trips). Could use UPSERT with RETURNING (SQLite 3.35+) to reduce to 1-2 statements.`
  - Source: `engine/quota_ledger.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/quota_ledger.py: Module-level DB_PATH and _POOL_ENABLED evaluated at import time. Environment variable changes after import are ignored.`
  - Source: `engine/quota_ledger.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/quota_ledger.py: Duplicated logic: check_quota and record_usage both fetch adapter row, compute today, and calculate effective usage.`
  - Source: `engine/quota_ledger.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/reasoning_ledger.py: State machine transitions hardcoded in module global; cannot be extended or configured without code changes`
  - Source: `engine/reasoning_ledger.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/sanitization_pipeline.py: _neutralize_capturing_groups uses naive string replacement (counting '(' and replacing with '(?:') which breaks on escaped parentheses '\(|\)', parentheses inside character classes '[()]', or existing`
  - Source: `engine/sanitization_pipeline.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/sanitization_pipeline.py: calculate_entropy creates a Counter for every token, allocating a dict and iterating all characters. For long payloads with many high-entropy tokens (e.g., base64 blobs), this is CPU-intensive. No ear`
  - Source: `engine/sanitization_pipeline.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/sanitization_pipeline.py: Magic numbers as string defaults in _load_env_float/_load_env_int calls (e.g., '4.5', '17', '100', '100000', '0.3') are scattered across constant initializations. Changing defaults requires editing mu`
  - Source: `engine/sanitization_pipeline.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/strict_quorum.py: Magic number '3' used for quorum size without a named constant. Appears again in approval threshold (line 68) and worker independence check (line 40).`
  - Source: `engine/strict_quorum.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/strict_quorum.py: Magic number '2' for approval threshold without a named constant.`
  - Source: `engine/strict_quorum.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/telemetry.py: No type hints, no docstrings, multiple imports on one line (PEP 8), hardcoded sanitization keys reduce maintainability and testability`
  - Source: `engine/telemetry.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/telemetry.py: _enforce_cap called twice per log_attempt (lines 92 and 96), doubling filesystem scanning overhead`
  - Source: `engine/telemetry.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/worker_vote_contract.py: Dataclass lacks field validation, docstrings for each field, and uses raw strings for typed concepts (decision, timestamp, hashes).`
  - Source: `engine/worker_vote_contract.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/writeback/authorization.py: No validation that action is one of allowed values (NO_ACTION, ENRICH, ESCALATE, REVIEW_REQUIRED) or target is a known target. Invalid values silently accepted.`
  - Source: `engine/writeback/authorization.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/writeback/authorization.py: Parameter serialization logic duplicated in verify_parameters (lines 36-37) and create_authorization (lines 51-52). Risk of divergence causing verification failures.`
  - Source: `engine/writeback/authorization.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/writeback/so_cases.py: sanitize_input() allocates a 2048-character string ('x' * 2048) for every input dictionary, causing unnecessary memory pressure`
  - Source: `engine/writeback/so_cases.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/writeback/so_cases.py: Imports (json, sys, hashlib, typing) placed after class definition instead of module top, violating PEP 8 and reducing readability`
  - Source: `engine/writeback/so_cases.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] memory/retention.py: Single partition case creates new connection instead of using pool; inconsistent with multi-partition path`
  - Source: `memory/retention.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] memory/retention.py: Duplicate dry-run logic between execute_archive_plan and archive_partition; violates DRY`
  - Source: `memory/retention.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] overnight/advisory_budget.py: failed_candidate_fingerprints set is initialized but never used anywhere in the codebase. Indicates incomplete feature or dead code.`
  - Source: `overnight/advisory_budget.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] overnight/build_v117.py: Entire script is procedural with 18+ hardcoded string replacements in global scope; no functions, no configuration, impossible to test or reuse`
  - Source: `overnight/build_v117.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] overnight/code_reviewer.py: Module-level `sys.path.insert(0, ...)` modifies import path at runtime. Fragile: breaks if script moved, run from different CWD, or installed as package. Violates 'no module-level side effects'.`
  - Source: `overnight/code_reviewer.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] overnight/code_reviewer.py: Runtime imports of private function `_call_gemini` inside `review_file` (lines 353, 378). Private APIs are unstable; runtime imports hinder static analysis and testing.`
  - Source: `overnight/code_reviewer.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] overnight/code_reviewer.py: `extract_json_from_response` is overly complex (200+ lines) with regex, bracket balancing, and multiple fallback strategies. Fragile, hard to test, and duplicates JSON parsing logic.`
  - Source: `overnight/code_reviewer.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] overnight/codebase_auditor.py: test_dir.glob('test_*.py') only scans top-level tests directory, missing tests in subdirectories (e.g., tests/unit/, tests/integration/).`
  - Source: `overnight/codebase_auditor.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] overnight/docstring_injector.py: requests import inside try/except at module level - unusual pattern, hides import errors until runtime`
  - Source: `overnight/docstring_injector.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] overnight/docstring_injector.py: call_gemini function lacks type hints for return value and parameters - ironic for a docstring injector tool`
  - Source: `overnight/docstring_injector.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] overnight/docstring_injector.py: process_file function lacks type hints and has high cyclomatic complexity - does reading, API call, validation, backup, writing`
  - Source: `overnight/docstring_injector.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] overnight/generate_docs.py: load_api_keys() called inside task loop instead of once before loop`
  - Source: `overnight/generate_docs.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] overnight/generate_docs.py: Module-level sys.path modification creates import side effects if this module is imported elsewhere`
  - Source: `overnight/generate_docs.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] overnight/llm_client.py: get_fallback_list() called on every _call_openrouter() invocation. It performs network I/O (discover_free_models) on cache miss, adding latency to every request.`
  - Source: `overnight/llm_client.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] overnight/llm_client.py: _call_groq() is 87 lines with nested loops, multiple passes, cooldown logic, token tracking, and rate-limit parsing. High cyclomatic complexity makes it hard to test and maintain.`
  - Source: `overnight/llm_client.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] overnight/llm_client.py: _original_generate() is 70 lines handling provider fallback, system prompt selection, budget checks, and retry logic. Violates single responsibility principle.`
  - Source: `overnight/llm_client.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] overnight/openrouter_quota.py: Missing type hints for all public and private functions. This reduces IDE support, makes refactoring riskier, and obscures expected data shapes (e.g., the quota state dict).`
  - Source: `overnight/openrouter_quota.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] overnight/overnight_verify_and_develop.py: No type hints on any functions or variables reducing IDE support and making refactoring error-prone`
  - Source: `overnight/overnight_verify_and_develop.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] overnight/overnight_verify_and_develop.py: No docstrings for any functions (only module docstring) making it hard to understand purpose, args, returns`
  - Source: `overnight/overnight_verify_and_develop.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] overnight/phase6_generate.py: load_api_keys() called inside generation loop (up to 3 times per task) causing repeated file I/O`
  - Source: `overnight/phase6_generate.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] overnight/phase6_generate.py: load_env() doesn't handle quoted values, escaped characters, 'export ' prefix, or values containing '='`
  - Source: `overnight/phase6_generate.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] overnight/pi_idle_reviewer.py: Hardcoded Redis connection parameters (host, port, db) and magic numbers reduce configurability and testability`
  - Source: `overnight/pi_idle_reviewer.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] overnight/refeed_bundle.py: Entire bundle_text embedded in prompt without token counting — bundle may exceed context window, causing silent truncation or API rejection`
  - Source: `overnight/refeed_bundle.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] overnight/safety_gates.py: Return type annotation is just 'tuple' instead of 'tuple[bool, str]' (Python 3.9+) or 'Tuple[bool, str]' (typing). Reduces type safety and IDE support.`
  - Source: `overnight/safety_gates.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] overnight/safety_gates.py: Double ast.walk() traversal: outer walk visits all nodes, then for each FunctionDef, inner walk visits all descendant nodes again. O(n^2) for deeply nested code. Also re-checks yields for every functi`
  - Source: `overnight/safety_gates.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] overnight/verifier.py: VerifierResult class lacks type hints, dataclass decorator, and __repr__; manual __init__ is verbose and error-prone`
  - Source: `overnight/verifier.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] overnight/verifier.py: verify_no_hallucinated_imports: missing type hints, redundant 'from pathlib import Path' inside function (line 27), complex logic without docstring explaining 'hallucinated imports' concept`
  - Source: `overnight/verifier.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] overnight/verifier.py: verify_no_secrets: missing type hints, hardcoded patterns not easily extensible, no docstring`
  - Source: `overnight/verifier.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] overnight/verifier.py: verify_task: missing type hints for task parameter (should be TypedDict or dict with known keys), multiple responsibilities (file checks, evidence writing, result construction)`
  - Source: `overnight/verifier.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] tools/alert_pipeline.py: Model lacks Pydantic config for immutability and extra field rejection, allowing accidental mutation and silent acceptance of unknown fields`
  - Source: `tools/alert_pipeline.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] tools/audit.py: Memory exhaustion risk: ledger.read_text().splitlines() loads entire file into memory; for large .jsonl buffers this causes OOM`
  - Source: `tools/audit.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] tools/audit.py: Missing type hints: function signatures and variables lack type annotations, reducing IDE support and maintainability`
  - Source: `tools/audit.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] tools/batch_aider.py: Function run_batch missing type hints for parameters and return type`
  - Source: `tools/batch_aider.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] tools/batch_aider.py: Function run_batch missing docstring describing parameters, behavior, and return value`
  - Source: `tools/batch_aider.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] tools/batch_aider.py: Tasks run sequentially with no parallelization; 300s timeout per task means batch could take hours`
  - Source: `tools/batch_aider.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] tools/build_efficacy_matrix.py: Inline import inside exception handler: 'import logging' inside try/except is anti-pattern; also logs then re-raises without wrapping in RuntimeError per AMEND-64`
  - Source: `tools/build_efficacy_matrix.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] tools/build_efficacy_matrix.py: Missing type hints throughout: no function signatures, return types, or variable annotations; reduces IDE support and refactoring safety`
  - Source: `tools/build_efficacy_matrix.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] tools/build_efficacy_matrix.py: Inefficient multiple passes: events sorted per remediation_id (line 52), then iterated 3+ times (lines 54-60, 66, 68-74) - O(n²) for large remediation chains`
  - Source: `tools/build_efficacy_matrix.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] tools/changelog_completeness_check.py: main() function is 87 lines with 5 nested functions, violating single responsibility; difficult to test and maintain`
  - Source: `tools/changelog_completeness_check.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] tools/changelog_completeness_check.py: get_commits_since_tag loads all commits into memory at once via list(); could OOM on repos with many commits since last tag`
  - Source: `tools/changelog_completeness_check.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] tools/deferred_dedup.py: Two round-trips to database (SELECT then INSERT/UPDATE). Could use single UPSERT statement.`
  - Source: `tools/deferred_dedup.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] tools/deferred_dedup.py: Three separate queries in get_stats. Could combine into single query with window functions or multiple result sets.`
  - Source: `tools/deferred_dedup.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] tools/deferred_dedup.py: Repeated connection boilerplate in is_duplicate, add_or_update, get_stats. Violates DRY, increases bug surface.`
  - Source: `tools/deferred_dedup.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] tools/diagnostics/analyze_escalations_readonly.py: check_assertion prints directly to stdout instead of returning structured results - makes testing and programmatic use difficult`
  - Source: `tools/diagnostics/analyze_escalations_readonly.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] tools/diagnostics/analyze_escalations_readonly_v2.py: inspect_jsonl loads all lines into memory (raw.splitlines()), then all parsed JSON into `parsed` list, then filters to `dict_records` list, then builds key_counts Counter. Three full copies of data in`
  - Source: `tools/diagnostics/analyze_escalations_readonly_v2.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] tools/diagnostics/analyze_escalations_readonly_v3.py: truncate function uses magic number 100; formatting widths (72, 90, 14, 10, 22, etc.) are hardcoded throughout, making output adjustments difficult`
  - Source: `tools/diagnostics/analyze_escalations_readonly_v3.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] tools/dashboard.py: _size_mb uses path.rglob('*') which recursively traverses all files. On directories with many files (e.g., oracle_queue/pending with thousands of JSON files), this causes significant latency.`
  - Source: `tools/dashboard.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] tools/diagnostics/audit_equivalence_patterns_readonly.py: Pattern names defined in ADVISORY_PATTERNS are duplicated in SAFE_CANDIDATES (line 253) and SAFE_ORDER (line 353). Adding/removing patterns requires updating three locations.`
  - Source: `tools/diagnostics/audit_equivalence_patterns_readonly.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] tools/diagnostics/audit_high_risk_routing_readonly.py: O(n*m) term matching for each queue item; inefficient for large term lists or queues`
  - Source: `tools/diagnostics/audit_high_risk_routing_readonly.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] tools/diagnostics/audit_manual_review_readonly.py: read_json reads entire file into memory with `f.read()` before parsing; for large backlog files this can cause MemoryError. json.load(f) streams directly from file handle.`
  - Source: `tools/diagnostics/audit_manual_review_readonly.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] tools/diagnostics/audit_nas_references_readonly.py: Nested loop tests every pattern against every line (O(lines * patterns)). With 7 patterns this is manageable, but scales poorly. Each rx.search() call has regex overhead.`
  - Source: `tools/diagnostics/audit_nas_references_readonly.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] tools/diagnostics/audit_tdd_prompt_change_readonly.py: Runtime sys.path.insert(0, str(REPO_ROOT)) modifies global import state. This breaks test isolation, causes flaky imports, and makes the module unimportable without side effects.`
  - Source: `tools/diagnostics/audit_tdd_prompt_change_readonly.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] tools/dynamic_vram_budget_check.py: import logging inside conditional branch (line 78) is an anti-pattern. Module-level imports should be at top of file.`
  - Source: `tools/dynamic_vram_budget_check.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] tools/external_credential_permission_check.py: validate_config() duplicates Pydantic validation logic - manually checks required keys and types, then load_config() calls Config(**cfg) which re-validates via Pydantic validators`
  - Source: `tools/external_credential_permission_check.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] tools/ioc_scanner.py: Code contains 'Example IOC detection' comment but is deployed as production logic. Placeholder implementation lacks support for standard IOC types (domains, hashes, URLs, emails, CVEs) required by SOC`
  - Source: `tools/ioc_scanner.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] tools/llm_redteam_corpus_generator.py: The functions generate_authority_escalation and generate_missing_fields duplicate the base recommendation dictionary logic from generate_valid_baseline, leading to code duplication and maintenance bur`
  - Source: `tools/llm_redteam_corpus_generator.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] tools/pi_redis_ingestor.py: LEDGER_PATH hardcoded to ~/Documents/soc-autopilot/overnight/improvement_ledger.jsonl. Not configurable via environment, breaks in containers/different deployments.`
  - Source: `tools/pi_redis_ingestor.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] tools/process_oracle.py: Missing type hints, docstrings, and module-level documentation. Function signatures lack return types and parameter types.`
  - Source: `tools/process_oracle.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] tools/queue_backpressure_check.py: check_backpressure() lacks detailed docstring documenting parameters, return values, and side effects`
  - Source: `tools/queue_backpressure_check.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] tools/queue_stale_recovery_check.py: check_queue_recovery prints status messages directly, coupling verification logic to console output. This hinders testing, reuse, and structured logging.`
  - Source: `tools/queue_stale_recovery_check.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] tools/sanitization_entropy_check.py: significant code duplication between sanitize_pass() and sanitize_stream(). Both implement nearly identical token processing logic (allowlist check, length guard, entropy calculation, redaction).`
  - Source: `tools/sanitization_entropy_check.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] tools/sanitization_field_policy_check.py: find_forbidden path building logic is fragile and hard to read; uses string concatenation in loop`
  - Source: `tools/sanitization_field_policy_check.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] tools/sanitization_redaction_check.py: Module-level functions (redact, run_sanitization_check, add_pattern, etc.) duplicate Sanitizer methods, creating maintenance burden and two APIs to keep in sync`
  - Source: `tools/sanitization_redaction_check.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] tools/sanitize_tests.py: Spawning separate pytest process for each test file incurs significant overhead; with many auto-generated tests this becomes slow`
  - Source: `tools/sanitize_tests.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] tools/shadow_canary.py: Function signature declares `-> bool` but returns `Union[bool, dict]`. Type hint is misleading.`
  - Source: `tools/shadow_canary.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] tools/sigma_generator.py: sys.path manipulation makes code fragile to directory structure changes and breaks in packaged deployments`
  - Source: `tools/sigma_generator.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] tools/system_doctor.py: Building a Counter by loading all lines into memory first is inefficient for large ledgers; streaming line-by-line reduces memory footprint.`
  - Source: `tools/system_doctor.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] tools/vector_partition_index_check.py: Exit code constants duplicated in main() function (lines 387-390), creating maintenance burden and divergence risk`
  - Source: `tools/vector_partition_index_check.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] overnight/llm_client.py: load_api_keys reads and parses .env file on every call with no caching, causing unnecessary I/O`
  - Source: `overnight/llm_client.py`

- [ ] **🟡 Overnight Error**
  - Message: `[unknown] engine/aider_development_worker.py: _diff_vs_head runs git diff subprocess once per changed file (N+1 calls). For many files this is slow.`
  - Source: `engine/aider_development_worker.py`

- [ ] **🟡 Overnight Failure**
  - Message: `→ cache returned None → fetch again" with no diagnostic trail. |`
  - Source: `llm_analysis_20261010_020628.md`

- [ ] **🟡 Overnight Failure**
  - Message: `reason: "Legacy worker failed: {exc}"`
  - Source: `llm_analysis_20261010_015431.md`

- [ ] **🟡 Overnight Failure**
  - Message: `reason: "Aider worker failed: {exc}"`
  - Source: `llm_analysis_20261010_015431.md`

- [ ] **🟡 Overnight Failure**
  - Message: `at terminal worker/safety boundary: reason: "Aider provider attempt failed at a terminal worker/safety boundary: " + result.reason`
  - Source: `llm_analysis_20261010_015431.md`

- [ ] **🟡 Overnight Failure**
  - Message: `reason: "All eligible Aider providers failed: " + ", " + attempted + ". Last failure: " + last_result.reason`
  - Source: `llm_analysis_20261010_015431.md`

- [ ] **🟡 Overnight Failure**
  - Message: `paths, and recommend pre-refactoring tasks.`
  - Source: `llm_analysis_20261010_015431.md`

- [ ] **🟡 Overnight Failure**
  - Message: `{exc}"`
  - Source: `llm_analysis_20261010_015431.md`

- [ ] **🟡 Overnight Failure**
  - Message: `at a terminal worker/safety boundary: {reason}"`
  - Source: `llm_analysis_20261010_015431.md`

- [ ] **🟡 Overnight Failure**
  - Message: `{attempted}. Last failure: {reason}"`
  - Source: `llm_analysis_20261010_015431.md`

- [ ] **🟡 Overnight Failure**
  - Message: `{exc}" → the {exc} varies, but the pattern is legacy worker failure`
  - Source: `llm_analysis_20261010_015431.md`

- [ ] **🟡 Overnight Failure**
  - Message: `at a terminal worker/safety boundary: " + result.reason`
  - Source: `llm_analysis_20261010_015431.md`

- [ ] **🟡 Overnight Failure**
  - Message: `" + ", " + attempted + ". Last failure: " + last_result.reason`
  - Source: `llm_analysis_20261010_015431.md`

- [ ] **🟡 Overnight Failure**
  - Message: `at a terminal worker/safety boundary: {reason}`
  - Source: `llm_analysis_20261010_015431.md`

- [ ] **🟡 Overnight Failure**
  - Message: `{attempted}. Last failure: {reason}`
  - Source: `llm_analysis_20261010_015431.md`

- [ ] **🟡 Overnight Failure**
  - Message: `on the final constraint check.`
  - Source: `llm_analysis_20261010_015001.md`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/aider_provider.py: CompositeCatalog sorts by priority ascending but priority semantics (lower=higher priority) not documented in base class`
  - Source: `engine/aider_provider.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/audit_telemetry.py: The 'log_mandatory_event' method lacks a docstring describing parameters, return value, exceptions, and side effects.`
  - Source: `engine/audit_telemetry.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/audit_telemetry.py: 'json.dumps(record)' is called solely to validate serializability, but the result is discarded, causing unnecessary string allocation.`
  - Source: `engine/audit_telemetry.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/autopilot_runner.py: json.dumps(payload, sort_keys=True).encode() creates an intermediate string then encodes to bytes. For large payloads, this allocates unnecessary memory. Using separators=(',', ':') produces more comp`
  - Source: `engine/autopilot_runner.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/autopilot_runner.py: Hardcoded print formatting strings duplicated across _report_simulation_result and _report_investigation_outcome. Changes to output format require editing multiple locations.`
  - Source: `engine/autopilot_runner.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/autopilot_stress_test.py: Hash calculation uses json.dumps with sort_keys=True inside a loop. For large num_alerts, this is inefficient. The payload is nearly identical except timestamp.`
  - Source: `engine/autopilot_stress_test.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/canonical_envelope.py: collector_version and transform_version are free-form strings with no format validation. Inconsistent versioning (e.g., 'v1.2', '1.2.0', 'latest') breaks debugging and compatibility checks.`
  - Source: `engine/canonical_envelope.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/defeat_ledger.py: Both functions read entire ledger file (load_records) on every call. Ledger grows unbounded; O(N) scan per operation becomes slow over time.`
  - Source: `engine/defeat_ledger.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/deterministic_dedup.py: generate_alert_signature accesses nested payload fields with chained .get() calls but does not validate envelope structure. If envelope.payload is None or not a dict, AttributeError will propagate. No`
  - Source: `engine/deterministic_dedup.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/deterministic_dedup.py: cluster_alerts calls envelope.received_at.isoformat() twice per new cluster (lines 89-90) and once per existing cluster match (line 96). For high-volume streams, repeated isoformat() calls add unneces`
  - Source: `engine/deterministic_dedup.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/deterministic_enrichment.py: enrich_entities processes indicators sequentially. For large entity sets (hundreds of IPs/domains), this creates latency. No concurrency or batching.`
  - Source: `engine/deterministic_enrichment.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/deterministic_enrichment.py: Mock providers defined in production module. This mixes test infrastructure with production code, increasing attack surface and confusion.`
  - Source: `engine/deterministic_enrichment.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/deterministic_enrichment.py: Providers hardcoded in __init__. Prevents runtime configuration, testing with stubs, or adding new providers without code change.`
  - Source: `engine/deterministic_enrichment.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/deterministic_enrichment.py: enrich_indicator lacks docstring describing return value semantics, possible statuses, and confidence meaning.`
  - Source: `engine/deterministic_enrichment.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/deterministic_policy.py: RecommendationEnvelope alias creates naming confusion (two names for same class) without clear benefit.`
  - Source: `engine/deterministic_policy.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/development_budget_broker.py: Response construction uses clever but opaque dict unpacking: `**({} if reserved else {'reason': 'BUDGET_EXHAUSTED'})`. Reduces readability for marginal brevity gain.`
  - Source: `engine/development_budget_broker.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/development_candidate.py: Dataclass lacks __slots__, __hash__, and __eq__ for identity-based comparison. Default dataclass equality compares all fields, not just candidate_id. No memory optimization for potentially thousands o`
  - Source: `engine/development_candidate.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/development_orchestrator.py: Hardcoded 'aider' backend string in generator_id construction. If backend changes or multiple backends are supported, this becomes misleading and requires code change.`
  - Source: `engine/development_orchestrator.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/development_worker_dispatch.py: Provider rotation attempts providers sequentially without any delay or backoff, which could hammer a failing provider or trigger rate limits`
  - Source: `engine/development_worker_dispatch.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/development_worker_dispatch.py: DevelopmentWorkerDispatchResult.worker_result is typed as 'Any' which defeats type checking and makes downstream code fragile`
  - Source: `engine/development_worker_dispatch.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/development_worker_gate.py: WorkerApprovalVote dataclass marked as legacy but still used in production evaluate_worker_quorum path. No deprecation warning or migration path indicated.`
  - Source: `engine/development_worker_gate.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/development_worker_pipeline.py: Sorting `unauthorized` paths for the error message allocates a new list and performs O(n log n) work. For typical small numbers of unauthorized files this is negligible, but could be avoided.`
  - Source: `engine/development_worker_pipeline.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/dry_run_executor.py: _SIMULATORS dispatch table uses string literals as keys that must match ActionType literal values. If ActionType is updated but _SIMULATORS is not, runtime KeyError occurs.`
  - Source: `engine/dry_run_executor.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/failure_autopsy.py: Function lacks detailed docstring for return value format (2-sentence constraint) and side effects; api_keys parameter structure not documented`
  - Source: `engine/failure_autopsy.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/failure_autopsy.py: Hardcoded truncation limits (1500, 2000 chars) and token limit (200) may be suboptimal for different error/code sizes; no dynamic adjustment based on model context window`
  - Source: `engine/failure_autopsy.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/git_isolation.py: Cleanup failures are completely silent. No logging makes debugging orphaned worktrees or failed cleanups difficult in production.`
  - Source: `engine/git_isolation.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/git_isolation.py: mkdir(parents=True) called every invocation even if .worktrees exists. Minor overhead but unnecessary syscall.`
  - Source: `engine/git_isolation.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/hash_chain_sealer.py: get_last_chain_state uses ORDER BY chain_seq DESC LIMIT 1 without FOR UPDATE. Under concurrent sealers (even with advisory lock), a race condition could occur if the lock is not held during this read.`
  - Source: `engine/hash_chain_sealer.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/hash_chain_sealer.py: fetch_pending_batches yields batches but the pending_cursor is a server-side cursor. For very large result sets, fetchmany may be slow; consider using cursor.itersize to tune fetch size.`
  - Source: `engine/hash_chain_sealer.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/hash_chain_sealer.py: _advisory_lock context manager acquires lock but does not handle the case where _acquire_lock blocks indefinitely (e.g., deadlock). No timeout mechanism.`
  - Source: `engine/hash_chain_sealer.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/inference_service.py: The module-level `logger` is defined but never used. Dead code increases cognitive load and may indicate missing observability.`
  - Source: `engine/inference_service.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/intake_eve.py: allowed_keys in sanitize_event is a hardcoded local set; should be a module-level constant for visibility and testability`
  - Source: `engine/intake_eve.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/intake_eve.py: sanitize_value is a trivial wrapper around sanitize_recursive adding no value; adds indirection`
  - Source: `engine/intake_eve.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/intake_eve.py: shannon_entropy creates Counter object for every call; for high-throughput intake this allocates many temporary objects`
  - Source: `engine/intake_eve.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/intake_eve.py: get_pending_events sets conn.row_factory = sqlite3.Row redundantly; get_connection already sets this`
  - Source: `engine/intake_eve.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/intake_wazuh.py: sanitize_payload returns tuple (alert_record, error) but parse_and_validate only uses the first element and checks second for error. The tuple pattern is inconsistent with other functions that raise e`
  - Source: `engine/intake_wazuh.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/intake_wazuh.py: _audit_log creates a new dict copy of details and adds correlation_id. For high-volume intake, this allocation per audit entry adds up. Could mutate details in place if caller doesn't reuse, or use {*`
  - Source: `engine/intake_wazuh.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/investigation_controller.py: Magic string '5710' for Wazuh SSH Brute Force rule ID hardcoded in mock LLM logic.`
  - Source: `engine/investigation_controller.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/investigation_controller.py: `datetime.now(timezone.utc)` called on every loop iteration. Acceptable for low iteration counts but could be optimized by checking wall time less frequently.`
  - Source: `engine/investigation_controller.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/investigation_controller.py: Two consecutive state assignments (`NORMALIZED` then `INVESTIGATING`) with no intermediate logic. The `NORMALIZED` state is never observed.`
  - Source: `engine/investigation_controller.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/investigation_controller.py: State set to NORMALIZED then immediately to INVESTIGATING; NORMALIZED state never observed or used`
  - Source: `engine/investigation_controller.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/investigation_controller.py: Three rapid state transitions (WAITING_FOR_EVIDENCE -> EVALUATING -> INVESTIGATING) in synchronous code; intermediate states unobservable`
  - Source: `engine/investigation_controller.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/ioc_extractor.py: `get_pg_conn` name implies connection reuse/caching but actually creates new connections; behavior is confusing for callers expecting a pooled connection`
  - Source: `engine/ioc_extractor.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/ioc_extractor.py: sanitize_ioc() has repetitive validation logic for each IOC type. Adding new types requires modifying this function, violating Open/Closed principle.`
  - Source: `engine/ioc_extractor.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/ioc_extractor.py: extract_iocs_from_text() serializes entire alert to JSON string then parses it back to extract text fields. This double serialization is wasteful when input is already a dict.`
  - Source: `engine/ioc_extractor.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/isolated_worker_runner.py: Unbound `TypeVar('WorkerResult')` provides weak type safety. Type checkers treat it as `Any`, losing return type information for callers.`
  - Source: `engine/isolated_worker_runner.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/isolated_worker_runner.py: No structured logging for observability. In production SOC automation, operators need to trace which worker ran, on which branch, duration, and outcome without digging through logs.`
  - Source: `engine/isolated_worker_runner.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/isolated_worker_runner.py: Magic number 8 for UUID truncation embedded in f-string; not configurable, not documented, hard to change consistently`
  - Source: `engine/isolated_worker_runner.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/ledger.py: to_dict creates a new dict then updates with payload. Could use dictionary unpacking for cleaner, more efficient code: `{**envelope, **self.payload}`.`
  - Source: `engine/ledger.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/ledger.py: Payload extraction uses dict comprehension with tuple lookup. Could pre-compute envelope set for O(1) lookups instead of tuple iteration.`
  - Source: `engine/ledger.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/memory_store.py: find_matching predicate Callable type hint is too generic: Callable[[Dict[str, Any]], bool]. Doesn't document expected record structure or predicate contract.`
  - Source: `engine/memory_store.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/memory_store.py: find_matching predicate signature Callable[[Dict[str, Any]], bool] is too permissive. Predicates that mutate records or have side effects break the 'no autonomous decisions' principle.`
  - Source: `engine/memory_store.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/memory_store.py: append_unique recomputes record_fingerprint(item) for every existing record in the loop. For N existing records, this is N redundant hash computations when the fingerprint could be pre-computed or rea`
  - Source: `engine/memory_store.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/memory_store.py: append_record does not add 'memory_hash' to records, while append_unique does. This creates inconsistent record schemas in the same JSONL file if both functions are used, complicating downstream consu`
  - Source: `engine/memory_store.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/model_registry.py: Two separate list comprehensions filter providers by scope then by role. This iterates the provider list twice unnecessarily.`
  - Source: `engine/model_registry.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/multi_file_patcher.py: Unused import 'time' (only used for the problematic sleep in dead code function)`
  - Source: `engine/multi_file_patcher.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/multi_file_patcher.py: The `original.replace(patch.search, patch.replace, 1)` creates a full copy of the file content string. For large files with many patches, this causes O(n*m) memory allocation where n=file size, m=patc`
  - Source: `engine/multi_file_patcher.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/multi_file_patcher.py: time.sleep(0.1) inside a tight search loop causes 100ms delay per iteration, making patch application extremely slow for large files`
  - Source: `engine/multi_file_patcher.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/multi_file_patcher.py: Docstring for _find_patch_location_strict has incorrect line numbers in Args section (lines 185-186 appear to be copy-paste artifacts)`
  - Source: `engine/multi_file_patcher.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/openrouter_catalog.py: Backward compatibility shim is_available() returns True with comment "NEUTRALIZED". Appears to be dead code or placeholder with no callers.`
  - Source: `engine/openrouter_catalog.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/openrouter_catalog.py: Sorting key in free_models calls model.model_id.lower() twice per model (for "coder" and "code" checks).`
  - Source: `engine/openrouter_catalog.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/openrouter_catalog.py: JsonDict type alias uses dict[str, object] which is overly broad and reduces static analysis effectiveness.`
  - Source: `engine/openrouter_catalog.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/openrouter_catalog.py: free_models creates new set objects for input_modalities and output_modalities for every model in loop, unnecessary allocation`
  - Source: `engine/openrouter_catalog.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/openrouter_catalog.py: _all_zero_pricing missing return type hint in signature (has docstring but no -> bool annotation)`
  - Source: `engine/openrouter_catalog.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/openrouter_catalog.py: _parse_model parameter type JsonDict = dict[str, object] but function assumes specific keys exist, type hint is too loose`
  - Source: `engine/openrouter_catalog.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/openrouter_catalog.py: No retry logic in `fetch_catalog` for transient network failures (DNS, timeout, 5xx); single attempt causes hard failure`
  - Source: `engine/openrouter_catalog.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/openrouter_catalog.py: `free_models` creates new set objects for `inputs` and `outputs` on every iteration; minor allocation overhead for large catalogs`
  - Source: `engine/openrouter_catalog.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/openrouter_catalog.py: Complex sorting key in `free_models` uses boolean arithmetic (`"coder" not in ... and "code" not in ...`) which is clever but hard to read`
  - Source: `engine/openrouter_catalog.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/patch_parser.py: _calculate_lines_changed name implies it computes actual diff (added + removed lines), but it returns max(len(search), len(replace)). This is misleading for future maintainers.`
  - Source: `engine/patch_parser.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/patch_parser.py: Fuzzy similarity threshold (0.85) is hardcoded as a module constant. Different use cases may require stricter or looser matching, but there's no way to configure it without modifying the source.`
  - Source: `engine/patch_parser.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/path_utils.py: Magic constant `_ENGINE_DIR_DEPTH` with explanatory comment indicates fragile design. Comment and code can drift out of sync.`
  - Source: `engine/path_utils.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/queue_manager.py: `_enforce_approval` is a deprecated compatibility wrapper around `require_approval`. Adds confusion; should be removed or marked with `@deprecated`.`
  - Source: `engine/queue_manager.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/queue_manager.py: `enqueue` runs `COUNT(*)` on `pending` jobs every insert. Full index scan on large queues; could be slow under load.`
  - Source: `engine/queue_manager.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/queue_manager.py: `_init_schema` missing return type hint (`-> None`).`
  - Source: `engine/queue_manager.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/queue_priority.py: priority_case_sql returns a multi-line indented string that is immediately stripped. This allocates unnecessary temporary strings and processes whitespace on every call.`
  - Source: `engine/queue_priority.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/quorum_verifier.py: Multiple iterations over votes set: each helper method iterates the full set, causing 3 passes. For large vote sets, single-pass validation would be more efficient.`
  - Source: `engine/quorum_verifier.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/quota_ledger.py: QuotaAdapterNotFoundError documented as 'reserved for future use' but never raised. check_quota returns False instead.`
  - Source: `engine/quota_ledger.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/reasoning_ledger.py: BUFFER_DIR.mkdir(parents=True, exist_ok=True) called on every record_interaction invocation, unnecessary syscall overhead`
  - Source: `engine/reasoning_ledger.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/reasoning_ledger.py: CanonicalTelemetryEvent dataclass is mutable (no frozen=True), allowing accidental modification of canonical truth records`
  - Source: `engine/reasoning_ledger.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/reasoning_ledger.py: SHA256 computed on full prompt/response on every call; expensive for large payloads (e.g., multi-MB contexts)`
  - Source: `engine/reasoning_ledger.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/sanitization_pipeline.py: redact_regex_patterns uses a closure with nonlocal redaction_count. While functional, this pattern is less readable than a class-based approach or using a mutable list `[0]` for the counter. Also, mat`
  - Source: `engine/sanitization_pipeline.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/sanitization_pipeline.py: TOKEN_PATTERN.finditer scans the entire payload for tokens >= MIN_TOKEN_LENGTH. For large payloads (up to 100KB), this finds many overlapping matches (e.g., a 1000-char base64 string yields ~984 match`
  - Source: `engine/sanitization_pipeline.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/sanitization_pipeline.py: Module docstring mentions 'quarantined and replaced with a reference marker' but the quarantine marker is hardcoded as '[QUARANTINED_REF]' with no configuration option. The reference marker format is `
  - Source: `engine/sanitization_pipeline.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/sigma_parser.py: Significant code duplication between export_to_splunk and export_to_elastic: both have identical logic for extracting selection, fallback iteration, and empty detection handling. Violates DRY principl`
  - Source: `engine/sigma_parser.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/sigma_parser.py: Complex one-liner for mitre_attack_id extraction is hard to read and maintain. Combines get, default list, indexing, and isinstance check.`
  - Source: `engine/sigma_parser.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/strict_quorum.py: Redundant hash check logic duplicates validator responsibility. The manual check and validator.validate() both verify candidate hash, creating maintenance burden and potential for divergence.`
  - Source: `engine/strict_quorum.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/telemetry.py: DEFAULT_BUFFER_ROOT uses hardcoded 'overnight/.telemetry_buffer' relative to repo root; not configurable via environment variable for deployment flexibility`
  - Source: `engine/telemetry.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/telemetry_identity.py: Missing return type hint for event_identity`
  - Source: `engine/telemetry_identity.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/telemetry_identity.py: Missing type hints for deduplicate_events parameters and return value`
  - Source: `engine/telemetry_identity.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/telemetry_identity.py: Missing function docstrings describing parameters, return values, and behavior`
  - Source: `engine/telemetry_identity.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/trust_boundary.py: Using indent=2 in json.dumps adds unnecessary whitespace, increasing token consumption when passed to LLM. For machine-to-LLM communication, compact JSON is preferred.`
  - Source: `engine/trust_boundary.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/trust_boundary.py: Injection patterns are hardcoded as module-level constants. Adding/modifying patterns requires code change and redeployment. Patterns should be configurable (e.g., loaded from config file or database)`
  - Source: `engine/trust_boundary.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/trust_boundary.py: Module lacks a docstring describing its purpose, trust boundary model, and usage guidelines.`
  - Source: `engine/trust_boundary.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/trust_boundary.py: Type hint for labels uses a forward reference string 'TrustLabels' instead of proper import. While valid, it prevents static analysis tools from validating the type.`
  - Source: `engine/trust_boundary.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/worker_vote.py: vote parameter typed as bare `dict`; should use TypedDict or `dict[str, str]` for clarity and static analysis.`
  - Source: `engine/worker_vote.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/worker_vote.py: _canonical_payload creates a new list and joins strings on every call; for high-throughput voting, this allocates unnecessarily. Could cache the payload bytes in __post_init__ since WorkerIdentity is `
  - Source: `engine/worker_vote.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/writeback/authorization.py: signer field hardcoded to 'deterministic_policy_engine_v1'. Not configurable, making versioning/rotation difficult.`
  - Source: `engine/writeback/authorization.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/writeback/authorization.py: json.dumps with sort_keys=True and separators=(',', ':') allocates new string on every verification. Acceptable for small params but could be optimized.`
  - Source: `engine/writeback/authorization.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/writeback/pfsense_alias.py: Triggers hardcode actor string 'pfsense_alias_adapter' instead of using AUDIT_ACTOR constant; drift risk if constant changes`
  - Source: `engine/writeback/pfsense_alias.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/writeback/pfsense_alias.py: Uses print() for operational output while main() configures logging; inconsistent observability`
  - Source: `engine/writeback/pfsense_alias.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/writeback/pfsense_alias.py: rollback_plan() only prints to stdout; no return value limits programmatic use`
  - Source: `engine/writeback/pfsense_alias.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/writeback/so_cases.py: create_case() draft mode returns hardcoded 'DRAFT_ID_000' which is not realistic for testing and provides no variation`
  - Source: `engine/writeback/so_cases.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/writeback/wazuh_proposals.py: Duplicate audit logging: SQLite triggers (audit_proposals_insert, audit_proposals_status_change) AND manual _queue_audit_entry() calls both write to audit_log. Doubles audit entries for submit/approve`
  - Source: `engine/writeback/wazuh_proposals.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/writeback/wazuh_proposals.py: main() function is 93 lines with all command handling inline. Violates single responsibility, hard to test, difficult to extend with new commands`
  - Source: `engine/writeback/wazuh_proposals.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/writeback/wazuh_proposals.py: _load_config() validates env vars but prints warnings to stderr instead of using logging module. Inconsistent with production logging practices`
  - Source: `engine/writeback/wazuh_proposals.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] engine/writeback/wazuh_proposals.py: Single global SQLite connection (_db_connection) serializes all database operations. Under high throughput, becomes bottleneck. No connection pooling`
  - Source: `engine/writeback/wazuh_proposals.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] memory/embeddings.py: _encode_internal lacks explicit return type annotation for the two different shapes (1D vs 2D array)`
  - Source: `memory/embeddings.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] memory/retention.py: Inconsistent retention_days default: function default None, argparse default 90, env var default 90; confusing precedence`
  - Source: `memory/retention.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] memory/retention.py: validate_commands uses module-level ZSTD_COMMAND constant instead of _load_config() value; env var override ignored`
  - Source: `memory/retention.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] memory/retention.py: COPY TO STDOUT WITH (FORMAT JSON) is slower than binary format; consider FORMAT BINARY with custom decoder for large partitions`
  - Source: `memory/retention.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] memory/retention.py: Missing docstring for _archive_partition_worker (dead code, but still)`
  - Source: `memory/retention.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] orchestrator/context_stitcher.py: _compute_query_hash packs each float individually in a loop. Using struct.pack with a single format string is more efficient.`
  - Source: `orchestrator/context_stitcher.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] orchestrator/context_stitcher.py: _execute_similarity_query lacks type hints for cursor parameter and return tuple elements. Reduces IDE support and static analysis.`
  - Source: `orchestrator/context_stitcher.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] orchestrator/context_stitcher.py: _format_context_blocks and _build_metadata lack type hints and docstrings. Hard to understand expected input/output without reading implementation.`
  - Source: `orchestrator/context_stitcher.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] orchestrator/context_stitcher.py: SQL query uses cosine_distance without verifying vector index exists. On large tables, this triggers sequential scan. No index hint or check.`
  - Source: `orchestrator/context_stitcher.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] orchestrator/model_registry.py: Duplicate error message strings for the two validation branches in `__init__` (both say 'Exactly one of routing_config_path or routing_config must be provided').`
  - Source: `orchestrator/model_registry.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/advisory_budget.py: Public function should_continue lacks docstring explaining its purpose, parameters, and return value.`
  - Source: `overnight/advisory_budget.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/advisory_budget.py: Public function terminate lacks docstring.`
  - Source: `overnight/advisory_budget.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/advisory_budget.py: Public function begin_model_attempt lacks docstring.`
  - Source: `overnight/advisory_budget.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/advisory_budget.py: Public function terminal_for_budget_exhaustion lacks docstring.`
  - Source: `overnight/advisory_budget.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/advisory_budget.py: Public function record_failure lacks docstring.`
  - Source: `overnight/advisory_budget.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/build_v117.py: Each content.replace() creates a new string copy; 18+ full passes over ~500KB+ document is inefficient`
  - Source: `overnight/build_v117.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/build_v117.py: Hardcoded filenames and paths reduce flexibility; cannot process different versions or locations without code changes`
  - Source: `overnight/build_v117.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/code_reviewer.py: Hardcoded `RATE_LIMIT_SLEEP = 4` blocks the main thread with `time.sleep`. Inflexible; no backoff/jitter. Limits throughput unnecessarily if API allows bursts.`
  - Source: `overnight/code_reviewer.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/code_reviewer.py: Unused import `ast` (line 12). Clutters namespace and suggests dead code.`
  - Source: `overnight/code_reviewer.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/code_reviewer.py: `generate_summary` is a 80-line function handling file discovery, JSON parsing, aggregation, and Markdown templating. Violates single responsibility; hard to test and modify.`
  - Source: `overnight/code_reviewer.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/code_reviewer.py: `generate_summary` loads all review JSON files into memory simultaneously (`reviews.append(data)`). Memory grows linearly with number of reviews.`
  - Source: `overnight/code_reviewer.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/codebase_auditor.py: No type hints on any method signatures or attributes, reducing IDE support and maintainability.`
  - Source: `overnight/codebase_auditor.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/codebase_auditor.py: Uses print() for all output instead of logging module, making it hard to control verbosity, redirect, or integrate with monitoring.`
  - Source: `overnight/codebase_auditor.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/demo_dual_model.py: Error message printed to stdout instead of stderr`
  - Source: `overnight/demo_dual_model.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/demo_dual_model.py: Import inside function (generate) reduces readability and prevents static analysis`
  - Source: `overnight/demo_dual_model.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/demo_dual_model.py: Import inside function (critique) reduces readability and prevents static analysis`
  - Source: `overnight/demo_dual_model.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/demo_dual_model.py: Missing type hints for main() function and variables`
  - Source: `overnight/demo_dual_model.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/docstring_injector.py: Sequential processing with fixed 7-second sleep between files - no parallelization, slow for many files`
  - Source: `overnight/docstring_injector.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/dump_deferred.py: Inefficient O(n) filtering in dump_one: list comprehension scans entire deferred list for each dump. With many deferred items, this is wasteful.`
  - Source: `overnight/dump_deferred.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/dump_deferred.py: Missing type hints on all functions (load, list_all, dump_one, main) reduces readability and static analysis capability.`
  - Source: `overnight/dump_deferred.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/generate_docs.py: Unused import 'subprocess' - dead code`
  - Source: `overnight/generate_docs.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/generate_docs.py: main() function is 88 lines with multiple responsibilities - violates single responsibility principle`
  - Source: `overnight/generate_docs.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/generate_docs.py: No type hints on any functions - reduces IDE support and maintainability`
  - Source: `overnight/generate_docs.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/generate_docs.py: Hardcoded project context in prompt - should be externalized or generated from codebase`
  - Source: `overnight/generate_docs.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/llm_client.py: Magic number 25000 for 'large prompt' threshold and hardcoded model keywords ('ultra', '550b', 'super-120b', 'compound') for high-capacity routing. Should be configurable constants.`
  - Source: `overnight/llm_client.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/llm_client.py: File lacks type hints on almost all functions. Makes code harder to maintain, refactor, and catch bugs early.`
  - Source: `overnight/llm_client.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/openrouter_quota.py: Missing docstrings for internal functions (`_load`, `_save`, `_refresh`, `_remaining`). Only `_refresh` has a one-line docstring. This hinders onboarding and maintenance.`
  - Source: `overnight/openrouter_quota.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/overnight_verify_and_develop.py: Hardcoded configuration constants (RUN_LLM_LOOP, API_BUDGET, MAX_SWEEPS) should be externalized to config file or env vars`
  - Source: `overnight/overnight_verify_and_develop.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/overnight_verify_and_develop.py: Import check re-imports all modules sequentially without caching; could be slow for large codebases`
  - Source: `overnight/overnight_verify_and_develop.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/overnight_verify_and_develop.py: Hardcoded package list for __init__.py check (engine, memory, orchestrator, tools, tests) doesn't adapt to project structure changes`
  - Source: `overnight/overnight_verify_and_develop.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/phase6_generate.py: Hardcoded API_URL and magic numbers (RATE_LIMIT_SLEEP, MAX_GENERATIONS_PER_TASK, MAX_TASKS_DEFAULT) without configuration options`
  - Source: `overnight/phase6_generate.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/phase6_generate.py: Missing type hints on functions: load_env, build_prompt, run_tests_for_file, process_task, main`
  - Source: `overnight/phase6_generate.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/phase6_generate.py: Missing docstrings on all functions except run_tests_for_file`
  - Source: `overnight/phase6_generate.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/phase6_generate.py: Fixed rate limit sleep without exponential backoff or jitter`
  - Source: `overnight/phase6_generate.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/phase6_generate.py: Argument parser in main() duplicates --tasks-file argument already parsed at module level (line 28-30)`
  - Source: `overnight/phase6_generate.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/pi_generator.py: Hardcoded configuration (OLLAMA_URL, MODEL, paths, MAX_ATTEMPTS) reduces deployability across environments`
  - Source: `overnight/pi_generator.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/pi_generator.py: Missing type hints on all functions and variables reduces IDE support and maintainability`
  - Source: `overnight/pi_generator.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/pi_generator.py: Print statements used throughout instead of structured logging; no log levels, no rotation, hard to parse in production`
  - Source: `overnight/pi_generator.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/pi_generator.py: Loads entire backlog, generated set, and attempted dict every cycle; inefficient for large files`
  - Source: `overnight/pi_generator.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/pi_generator.py: Hardcoded sleep times (60s, 300s, 15s) scattered in loop; not configurable and magic numbers`
  - Source: `overnight/pi_generator.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/pi_idle_reviewer.py: Missing type hints and docstrings for all functions; reduces IDE support and maintainability`
  - Source: `overnight/pi_idle_reviewer.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/pi_idle_reviewer.py: Fixed 300s polling interval regardless of workload; high latency for patch processing, wastes CPU when idle`
  - Source: `overnight/pi_idle_reviewer.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/refeed_bundle.py: Duplicate error handling pattern (print + sys.exit) repeated 3 times — violates DRY, makes error handling inconsistent`
  - Source: `overnight/refeed_bundle.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/refeed_bundle.py: Print statements used for operational logging — no log levels, no structured output, hard to parse in production`
  - Source: `overnight/refeed_bundle.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/refeed_bundle_v3.py: Hardcoded max_tokens and temperature values should be configurable constants`
  - Source: `overnight/refeed_bundle_v3.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/refeed_bundle_v3.py: Magic numbers 50000 and 80000 for truncation limits lack documentation`
  - Source: `overnight/refeed_bundle_v3.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/report.py: Missing type hints for function signatures and variables`
  - Source: `overnight/report.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/report.py: Missing module and function docstrings describing purpose, inputs, outputs, and side effects`
  - Source: `overnight/report.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/run_phase.py: Function missing type hints for parameter and return type.`
  - Source: `overnight/run_phase.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/run_phase.py: subprocess.run without check=True - returncode must be manually checked, easy to miss errors.`
  - Source: `overnight/run_phase.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/run_phase.py: Print statements used instead of logging - no log levels, no structured output, hard to suppress in production.`
  - Source: `overnight/run_phase.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/safety_gates.py: Regex uses confusing triple-single-quote raw string r'''["'](/home/|/Users/|/tmp/)'''. Hard to read and maintain.`
  - Source: `overnight/safety_gates.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/verifier.py: content.split('\n') called twice (once for line count, once in detail string); minor but unnecessary allocation`
  - Source: `overnight/verifier.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] overnight/verifier.py: Unused imports: hashlib, json, os, re, subprocess, sys are imported but not all used at module level (some only in functions); consider moving imports inside functions or removing unused`
  - Source: `overnight/verifier.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] tools/alert_pipeline.py: rule_name lacks non-empty validation, allowing empty strings that break downstream correlation`
  - Source: `tools/alert_pipeline.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] tools/analyze_drain_log.py: Entire log file loaded into memory with `read_text()` and `splitlines()`. For very large overnight logs (hundreds of MB), this causes unnecessary memory pressure.`
  - Source: `tools/analyze_drain_log.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] tools/analyze_drain_log.py: Rejection category strings are hardcoded in multiple if/elif branches, making it error-prone to add new categories or fix typos.`
  - Source: `tools/analyze_drain_log.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] tools/analyze_drain_log.py: No unit tests included or referenced. Critical parsing logic for production CI verification has no test coverage for edge cases (empty logs, malformed lines, new rejection types).`
  - Source: `tools/analyze_drain_log.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] tools/audit.py: Unused import: 'os' is imported but never used`
  - Source: `tools/audit.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] tools/audit.py: Trivial wrapper function: get_ledger_path() adds indirection without value; can be inlined`
  - Source: `tools/audit.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] tools/batch_aider.py: Magic numbers and hardcoded values (timeout=300, stderr slice 500, prompt preview 80) scattered in code`
  - Source: `tools/batch_aider.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] tools/batch_aider.py: Hardcoded default model string; should be configurable via env var or config file`
  - Source: `tools/batch_aider.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] tools/build_efficacy_matrix.py: Magic numbers in scoring weights (0.4, 0.4, 0.2) and minimum calls threshold (3) reduce readability and configurability`
  - Source: `tools/build_efficacy_matrix.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] tools/build_efficacy_matrix.py: Missing docstrings for public functions: gather_events, calculate_metrics, score_and_rank, main lack documentation of params, returns, and side effects`
  - Source: `tools/build_efficacy_matrix.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] tools/changelog_completeness_check.py: collect_commits return type annotation missing type parameter (List instead of List[str])`
  - Source: `tools/changelog_completeness_check.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] tools/changelog_completeness_check.py: print_results returns EXIT_PASS on dry-run even with missing entries; behavior documented but function name suggests it only prints`
  - Source: `tools/changelog_completeness_check.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] tools/deferred_dedup.py: DB_PATH uses relative path from __file__. Fails if script run from different working directory or if file structure changes.`
  - Source: `tools/deferred_dedup.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] tools/deferred_dedup.py: cleanup_existing_backlog calls init_db() internally, but init_db() also called in main. Redundant and confusing.`
  - Source: `tools/deferred_dedup.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] tools/dependency_mapper.py: ast.walk() visits every node in tree including nested function/class bodies. A NodeVisitor visiting only Import/ImportFrom nodes would be faster.`
  - Source: `tools/dependency_mapper.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] tools/dependency_mapper.py: Module docstring describes purpose but get_module_name() lacks docstring explaining its cwd assumption and return format.`
  - Source: `tools/dependency_mapper.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] tools/dependency_mapper.py: Variable `target_base` (filename stem) is used for fuzzy matching but name doesn't convey it's the module basename without extension.`
  - Source: `tools/dependency_mapper.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] tools/dependency_mapper.py: Uses os.walk() with string paths while rest of code uses pathlib.Path. Inconsistent path handling.`
  - Source: `tools/dependency_mapper.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] tools/diagnostics/analyze_escalations_readonly.py: probe_json_ledger reads entire file into memory with read_text_safe - could be large for jsonl files`
  - Source: `tools/diagnostics/analyze_escalations_readonly.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] tools/diagnostics/analyze_escalations_readonly.py: Duplicate status/category counting logic between probe_sqlite_ledger and probe_json_ledger`
  - Source: `tools/diagnostics/analyze_escalations_readonly.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] tools/diagnostics/analyze_escalations_readonly_v2.py: search_source compiles regex pattern on every call (rx = re.compile(pattern)). Called 6 times in main with same patterns. Minor but avoidable recompilation.`
  - Source: `tools/diagnostics/analyze_escalations_readonly_v2.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] tools/diagnostics/analyze_escalations_readonly_v2.py: schema_of_record truncates dict keys to first 6 sorted keys and list lengths only. For nested structures, this loses significant schema information. The output shows `dict(key1,key2,...)` but not valu`
  - Source: `tools/diagnostics/analyze_escalations_readonly_v2.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] tools/diagnostics/analyze_escalations_readonly_v3.py: Each analysis function (escalation_reasons, tdd_evaluated_outcomes, category_status_matrix, time_series, etc.) iterates over full ledger independently; 6+ full passes over data`
  - Source: `tools/diagnostics/analyze_escalations_readonly_v3.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] tools/diagnostics/analyze_escalations_readonly_v3.py: Module-level RuntimeError on import prevents any reuse of helper functions (read_jsonl, parse_ts, truncate) in tests or other tools`
  - Source: `tools/diagnostics/analyze_escalations_readonly_v3.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] tools/diagnostics/analyze_escalations_readonly_v3.py: proven_patterns_detail prints all proven records without truncation limit on advisory field in the loop (line 267 uses truncate but line 265 doesn't)`
  - Source: `tools/diagnostics/analyze_escalations_readonly_v3.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] tools/deferred_dedup.py: Repeated boilerplate for opening/closing SQLite connections in init_db, is_duplicate, add_or_update, and get_stats. Increases maintenance burden and error surface.`
  - Source: `tools/deferred_dedup.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] tools/dependency_mapper.py: Hardcoded directory exclusions (__pycache__, .git, tests) are not configurable. Projects with different structures (e.g., 'test/', 'venv/', '.venv/') will either scan unnecessary dirs or skip needed o`
  - Source: `tools/dependency_mapper.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] tools/diagnostics/audit_dashboard_readonly.py: Functions lack type hints and docstrings. Reduces IDE support and maintainability.`
  - Source: `tools/diagnostics/audit_dashboard_readonly.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] tools/embedding_prefix_check.py: `fake_encode` is defined at module level but only used inside `run_verification`. It references global `calls` and `REQUIRED_DIM`, reducing testability and clarity.`
  - Source: `tools/embedding_prefix_check.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] tools/embedding_prefix_idempotency_check.py: _load_cases parameter 'test_cases' missing type hint`
  - Source: `tools/embedding_prefix_idempotency_check.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] tools/hash_chain_concurrency_check.py: DEFAULT_STRESS_ITERATIONS (10) is hardcoded and not configurable via CLI. Operators cannot adjust iteration count for faster CI runs or more thorough testing without modifying source.`
  - Source: `tools/hash_chain_concurrency_check.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] tools/hash_chain_verify.py: verify_chain_memory missing docstring.`
  - Source: `tools/hash_chain_verify.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] tools/llm_analyze.py: Duplicate argument definition: '--file' (suppressed) and positional 'input_file' both map to same dest, causing confusion.`
  - Source: `tools/llm_analyze.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] tools/llm_fix_agent.py: Multiple imports on single line (ast, json, re, sys) reduces readability and diff clarity`
  - Source: `tools/llm_fix_agent.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] tools/memory_schema_migrate_check.py: Duplicate path computation: module-level PROJECT_ROOT/SCHEMA_PATH/LEDGER_PATH and again in _load_config(). Creates drift risk if one is updated and not the other.`
  - Source: `tools/memory_schema_migrate_check.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] tools/payload_ref_integrity_check.py: verify_payload() performs filesystem I/O directly, making unit testing difficult without temporary files or mocking.`
  - Source: `tools/payload_ref_integrity_check.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] tools/pi_findings_to_backlog.py: Hardcoded tool list ["pylint", "bandit"] requires code change to support new tools. Not extensible.`
  - Source: `tools/pi_findings_to_backlog.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] tools/review_queue.py: sys.exit(main()) in __main__ block makes the module less testable as a library. While acceptable for a CLI entry point, it prevents importing main() for integration testing without side effects.`
  - Source: `tools/review_queue.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] tools/sync_telemetry.py: Multiple imports on one line (os, sys, fcntl, subprocess) violates PEP 8 and makes diff review harder.`
  - Source: `tools/sync_telemetry.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] tools/verify_truth_sync.py: Hardcoded source_dirs list requires code change when new source directories are added`
  - Source: `tools/verify_truth_sync.py`

- [ ] **🟡 Overnight Failure**
  - Message: `[unknown] tools/wiki_sanitization_check.py: ALLOWLIST and PATTERNS hardcoded as module constants, preventing runtime configuration without code changes`
  - Source: `tools/wiki_sanitization_check.py`

- [ ] **🟡 Overnight Timeout**
  - Message: `or model provider exhaustion. `lease_failure` propagates as unhandled RuntimeError outside the inference try/finally. | **~24%**<br>*Secondary driver: Threaded lease heartbeat races and 30s hard timeo`
  - Source: `llm_analysis_20261010_020915.md`

- [ ] **🟡 Overnight Timeout**
  - Message: `kill) | `HashChainLedger.append_hash` uses `threading.Lock`; AI frequently removes/broadens lock scope, or introduces deadlocks via nested acquires. `except Exception: pass` in `worker()` masks race-i`
  - Source: `llm_analysis_20261010_013653.md`
