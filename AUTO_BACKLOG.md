# 🤖 Autonomous Backlog
*Generated: 2026-10-12T02:50:54*

## Instructions for Aider
- Pick the **top unchecked** item below
- Investigate root cause using available context
- Apply minimal surgical fix
- Run `python3 tools/quality_gate.py` and relevant tests
- Change `[ ]` to `[x]` when resolved
- If unfixable, add to `dashboard_memory.db` fix_patterns and skip

## 🔴 Prioritized Issues (282 found)

- [ ] **🔴 Test Regression**
  - Message: `==================================== ERRORS ====================================`
  - Source: `tests/`

- [ ] **🔴 Test Regression**
  - Message: `_______ ERROR at setup of test_check_cmr_mount_raises_when_not_available _______`
  - Source: `tests/`

- [ ] **🔴 Test Regression**
  - Message: `_________ ERROR at setup of test_check_cmr_mount_passes_when_available _________`
  - Source: `tests/`

- [ ] **🔴 Test Regression**
  - Message: `ERROR tests/test_retention.py::test_check_cmr_mount_raises_when_not_available`
  - Source: `tests/`

- [ ] **🔴 Test Regression**
  - Message: `ERROR tests/test_retention.py::test_check_cmr_mount_passes_when_available`
  - Source: `tests/`

- [ ] **🔴 Test Regression**
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
  - Message: `[pi_edge_bandit] engine/writeback/so_cases.py: [PYLINT E1121] Consider refactoring the lambda function to pass fewer arguments.`
  - Source: `engine/writeback/so_cases.py`

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
