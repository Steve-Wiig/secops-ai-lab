#!/usr/bin/env python3
"""
P0/P1 Quality Gate: Scans codebase for critical anti-patterns.
SAFE REGEX: No re.DOTALL with .* to prevent ReDoS hangs.
"""
import os
import re
import sys

# Safe, linear-time regex patterns
P0_PATTERNS = [
    (r"except\s+Exception[^:]*:\s*\n\s*pass", "P0: Silent failure (except Exception: pass)"),
]

P1_PATTERNS = [
    (r"\b(requests\.get|requests\.post|urllib\.request\.urlopen)\s*\([^)]*\)", "P1: Network request - verify timeout is set"),
    (r"\b(sqlite3\.connect|time\.sleep)\b", "P1: Blocking call - ensure not in async route (use asyncio.to_thread)"),
]


# Directories/files that are CLI scripts or tests — never async routes
NON_ASYNC_DIRS = {'tests', 'simulator', 'scripts', 'diagnostics'}
NON_ASYNC_FILES = {
    'backlog_scanner.py', 'fix_p1_issues.py', 'quality_gate.py',
    'embedding_prefix_idempotency_check.py', 'pi_redis_ingestor.py',
    'deferred_dedup.py', 'queue_backpressure_check.py',
    'verify_dashboard.py', 'analyze_escalations_readonly.py',
    'analyze_escalations_readonly_v2.py',
}
NON_ASYNC_PREFIXES = ('overnight/',)

def is_async_context(filepath):
    """Check if file could contain async routes."""
    rel = os.path.relpath(filepath, '.')
    parts = rel.split(os.sep)
    if any(d in NON_ASYNC_DIRS for d in parts):
        return False
    if os.path.basename(rel) in NON_ASYNC_FILES:
        return False
    if any(rel.startswith(pfx) for pfx in NON_ASYNC_PREFIXES):
        return False
    return True

def scan_file(filepath):
    issues = []
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
            
        for pattern, msg in P0_PATTERNS:
            if re.search(pattern, content, re.MULTILINE):
                issues.append(f"🚨 {msg} in {filepath}")
                
        file_is_async = is_async_context(filepath)
        for pattern, msg in P1_PATTERNS:
            # Only check blocking calls in async-capable files
            if 'Blocking call' in msg and not file_is_async:
                continue
            for i, line in enumerate(content.splitlines(), 1):
                stripped = line.strip()
                # Skip import lines, except handlers, comments, and lines already having timeout
                if stripped.startswith(('import ', 'from ', '#', 'except ')):
                    continue
                if 'timeout' in line:
                    continue
                if re.search(pattern, line):
                    if "noqa" in line:
                        continue  # Intentional, skip
                    issues.append(f"⚠️ {msg} in {filepath}:{i}")
                    break  # One warning per file per pattern
                
    except Exception as e:
        print(f"⚠️ Could not scan {filepath}: {e}")
    return issues

def main():
    print("=== 🛡️ P0/P1 QUALITY GATE SCAN ===")
    all_issues = []
    
    for root, dirs, files in os.walk('.'):
        dirs[:] = [d for d in dirs if not d.startswith('.') and d not in ('venv', 'node_modules', '__pycache__')]
        
        for file in files:
            if file.endswith('.py'):
                filepath = os.path.join(root, file)
                all_issues.extend(scan_file(filepath))
                
    if all_issues:
        p0_count = sum(1 for i in all_issues if i.startswith("🚨"))
        print(f"\n⚠️ FOUND {len(all_issues)} ISSUES ({p0_count} P0 Critical):\n")
        for issue in all_issues:
            print(f"  {issue}")
            
        if p0_count > 0:
            print("\n❌ COMMIT BLOCKED: Fix P0 issues first!")
            sys.exit(1)
        else:
            print("\n✅ P0 CLEAN: P1 warnings noted, proceeding.")
            sys.exit(0)
    else:
        print("\n✅ CODEBASE CLEAN: No P0/P1 anti-patterns detected.")
        sys.exit(0)

if __name__ == "__main__":
    main()
