"""
Memory storage primitives.

No model calls.
No autonomous decisions.
No promotion authority.

Provides:
- deterministic fingerprints
- duplicate-safe append
- corruption tolerant loading
- bounded retrieval
"""

import hashlib
import json
from pathlib import Path
from typing import Any, Callable, Dict, Generator, List


def record_fingerprint(record: Dict[str, Any]) -> str:
    """
    Compute a stable identity hash for a memory record.

    Excludes timestamp so repeated observations
    of the same failure deduplicate.

    Optimization: first checks if the record already has a
    ``memory_hash`` field. If present, uses that directly
    instead of recomputing the fingerprint.

    Args:
        record: The memory record to fingerprint.

    Returns:
        A hex-encoded SHA-256 digest derived from the
        record's identity-relevant fields.
    """

    # Fast path: use stored memory_hash if available
    stored_hash = record.get("memory_hash")
    if stored_hash:
        return stored_hash

    keys = [
        "category",
        "file",
        "advisory",
        "constraint",
        "failed_diff",
        "candidate_hash",
        "failure_signature",
        "signature",
    ]

    payload = {
        key: record.get(key, "")
        for key in keys
    }

    raw = json.dumps(
        payload,
        sort_keys=True,
        ensure_ascii=True,
    )

    return hashlib.sha256(
        raw.encode("utf-8")
    ).hexdigest()


def load_records(path: Path) -> Generator[Dict[str, Any], None, None]:
    """
    Load JSONL records from disk safely, yielding one record at a time.

    Missing files yield an empty generator. Invalid lines
    (malformed JSON) are silently skipped rather than
    raising, so a single corrupted line cannot break
    retrieval of the rest of the file.

    This generator-based approach avoids loading entire
    files into memory, making it safe for large JSONL files.

    Args:
        path: Path to the JSONL file.

    Yields:
        Individual parsed record dictionaries.
    """

    if not path.exists():
        return

    try:
        with path.open(
            encoding="utf-8"
        ) as f:

            for line in f:
                if not line.strip():
                    continue

                try:
                    yield json.loads(line)
                except json.JSONDecodeError:
                    continue

    except OSError:
        return


def append_unique(
    path: Path,
    record: Dict[str, Any],
) -> bool:
    """
    Append a record only if an identical memory does not already exist.

    Identity is determined by record_fingerprint(), which
    ignores volatile fields like timestamps.

    Optimization: first checks if the record already has a
    ``memory_hash`` field. If present, uses that directly
    instead of recomputing the fingerprint, avoiding O(n)
    hash recomputation per append.

    Args:
        path: Path to the JSONL file to append to.
        record: The record to append.

    Returns:
        True if the record was appended, False if it was
        a duplicate and therefore skipped.
    """

    # Fast path: check existing memory_hash if present
    existing = load_records(path)

    new_hash = record_fingerprint(record)

    for item in existing:
        # Use stored memory_hash if available to avoid
        # recomputing the fingerprint
        stored_hash = item.get("memory_hash")
        if stored_hash and stored_hash == new_hash:
            return False
        if record_fingerprint(item) == new_hash:
            return False

    path.parent.mkdir(
        parents=True,
        exist_ok=True,
    )

    enriched_record = dict(record)
    enriched_record["memory_hash"] = new_hash

    with path.open(
        "a",
        encoding="utf-8",
    ) as f:
        f.write(
            json.dumps(enriched_record)
            + "\n"
        )

    return True


def append_record(
    path: Path,
    record: Dict[str, Any],
) -> None:
    """
    Append an event record without deduplication.

    Intended for immutable event streams:
    - defeat attempts
    - telemetry events
    - audit history

    Unlike append_unique(), repeated identical
    records are expected and preserved.

    Unlike append_unique(), this function now adds
    a ``memory_hash`` field for schema consistency.

    Args:
        path: Path to the JSONL file to append to.
        record: The record to append.
    """

    path.parent.mkdir(
        parents=True,
        exist_ok=True,
    )

    new_hash = record_fingerprint(record)

    enriched_record = dict(record)
    enriched_record["memory_hash"] = new_hash

    with path.open(
        "a",
        encoding="utf-8",
    ) as f:
        f.write(
            json.dumps(enriched_record)
            + "\n"
        )


def find_matching(
    path: Path,
    predicate: Callable[[Dict[str, Any]], bool],
    limit: int = 5,
) -> List[Dict[str, Any]]:
    """
    Retrieve up to `limit` records satisfying `predicate`.

    Args:
        path: Path to the JSONL file to search.
        predicate: A callable that receives a record and
            returns True if it should be included.
        limit: Maximum number of matching records to return.

    Returns:
        A bounded list of matching records, in file order.
    """

    results: List[Dict[str, Any]] = []

    for item in load_records(path):
        try:
            if predicate(item):
                results.append(item)

                if len(results) >= limit:
                    break

        except Exception:
            # Intentionally broad: a malformed record or a
            # predicate that raises on unexpected shapes must
            # not abort retrieval of the remaining records.
            continue

    return results


# ============================================================
# LEGACY COMPATIBILITY API
# ============================================================
#
# Existing callers continue using the original names.
# Implementation delegates to hardened primitives.
#
# No behavior authority added.
#


def fingerprint_failure(
    target: str,
    failure_signature: str,
    lesson: str,
) -> str:
    """
    Compute a fingerprint for a failure record.

    Args:
        target: The file or resource the failure relates to.
        failure_signature: Identifier describing the failure mode.
        lesson: The constraint/lesson learned from the failure.

    Returns:
        A hex-encoded SHA-256 digest identifying this failure.
    """
    return record_fingerprint(
        {
            "file": target,
            "failure_signature": failure_signature,
            "constraint": lesson,
        }
    )


def append_failure(
    path: Path,
    record: Dict[str, Any],
) -> bool:
    """
    Append a failure record if it is not a duplicate.

    Args:
        path: Path to the JSONL file to append to.
        record: The failure record to append.

    Returns:
        True if the record was appended, False if it was a duplicate.
    """
    return append_unique(
        path,
        record,
    )


def load_failures(path: Path) -> List[Dict[str, Any]]:
    """
    Load all failure records from disk.

    Args:
        path: Path to the JSONL file.

    Returns:
        A list of parsed failure record dictionaries.
    """
    return list(load_records(path))


def find_matching_failures(
    path: Path,
    fingerprint: str,
) -> List[Dict[str, Any]]:
    """
    Find failure records matching a given fingerprint.

    Matches either an explicit `fingerprint` field on the
    record or a record whose computed fingerprint equals
    the given value.

    Args:
        path: Path to the JSONL file to search.
        fingerprint: The fingerprint to match against.

    Returns:
        A bounded list of matching failure records.
    """
    return find_matching(
        path,
        lambda item: (
            item.get("fingerprint") == fingerprint
            or record_fingerprint(item) == fingerprint
        ),
    )
