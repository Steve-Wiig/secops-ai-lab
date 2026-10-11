#!/usr/bin/env python3
"""
Autonomous Backlog Scanner
Scans overnight logs, test results, and queue state to generate
a prioritized AUTO_BACKLOG.md for Aider to consume on next launch.
"""
import os
import re
import json
import sqlite3
import subprocess
from pathlib import Path
from datetime import datetime, timedelta
from collections import Counter

ROOT = Path(__file__).resolve().parent.parent
DB_PATH = ROOT / "tools" / "web_ui" / "dashboard_memory.db"
OUTPUT = ROOT / "AUTO_BACKLOG.md"

def get_known_patterns():
    """Load known fix patterns from memory DB to avoid duplicates."""
    try:
        conn = sqlite3.connect(DB_PATH)
        rows = conn.execute("SELECT symptom FROM fix_patterns").fetchall()
        conn.close()
        return {r[0].lower() for r in rows}
    except Exception as e:
        print(f'⚠️ Could not load known patterns: {e}')
        return set()

def scan_overnight_logs(max_files=20):
    """Parse recent overnight analysis logs for errors and warnings."""
    issues = []
    log_dir = ROOT / "overnight"
    if not log_dir.exists():
        return issues
    md_files = sorted(log_dir.glob("llm_analysis_*.md"), reverse=True)[:max_files]
    error_patterns = [
        (r"(?i)error[:\s]+(.+)", "overnight_error"),
        (r"(?i)failed[:\s]+(.+)", "overnight_failure"),
        (r"(?i)timeout[:\s]+(.+)", "overnight_timeout"),
        (r"(?i)exception[:\s]+(.+)", "overnight_exception"),
        (r"(?i)429|rate.?limit", "api_rate_limit"),
    ]
    for f in md_files:
        try:
            text = f.read_text(errors="replace")
            for pattern, category in error_patterns:
                for match in re.findall(pattern, text):
                    msg = match.strip()[:200] if isinstance(match, str) else str(match)[:200]
                    if msg and len(msg) > 5:
                        issues.append({"source": "overnight_log", "category": category, "message": msg, "file": f.name})
        except Exception as e:
            print(f'⚠️ Error scanning file: {e}')
            continue
    return issues

def scan_test_results():
    """Run pytest in collect-only + last-failed mode to find broken tests."""
    issues = []
    try:
        result = subprocess.run(["python3", "-m", "pytest", "--co", "-q", "--tb=no"], capture_output=True, text=True, cwd=ROOT, timeout=30)
        if result.returncode != 0 and "ERROR" in result.stdout:
            for line in result.stdout.splitlines():
                if "ERROR" in line or "ImportError" in line or "SyntaxError" in line:
                    issues.append({"source": "test_collection", "category": "test_import_error", "message": line.strip()[:200], "file": "tests/"})
    except Exception as e:
        issues.append({"source": "test_collection", "category": "test_infrastructure", "message": str(e)[:200], "file": "tests/"})
    try:
        result = subprocess.run(["python3", "-m", "pytest", "--lf", "-q", "--tb=line"], capture_output=True, text=True, cwd=ROOT, timeout=60)
        if result.returncode != 0:
            for line in result.stdout.splitlines():
                if "FAILED" in line or "ERROR" in line:
                    issues.append({"source": "test_failure", "category": "test_regression", "message": line.strip()[:200], "file": "tests/"})
    except Exception as e:
        print(f'⚠️ Test scan error: {e}')
    return issues

def scan_queue_state():
    """Check SQLite queue for dead-lettered or stuck items."""
    issues = []
    db_paths = [ROOT / "triage_queue.db", ROOT / "engine" / "triage_queue.db"]
    for db_path in db_paths:
        if not db_path.exists():
            continue
        try:
            conn = sqlite3.connect(db_path)
            try:
                count = conn.execute("SELECT COUNT(*) FROM triage_queue WHERE status = 'failed'").fetchone()[0]
                if count > 0:
                    issues.append({"source": "queue", "category": "dead_letter", "message": f"{count} dead-lettered items in triage_queue", "file": str(db_path.relative_to(ROOT))})
            except Exception as e:
                print(f'⚠️ Queue scan error: {e}')
            try:
                count = conn.execute("SELECT COUNT(*) FROM triage_queue WHERE status = 'processing' AND lease_expires_at < datetime('now')").fetchone()[0]
                if count > 0:
                    issues.append({"source": "queue", "category": "stale_lease", "message": f"{count} items with expired leases still in processing", "file": str(db_path.relative_to(ROOT))})
            except Exception as e:
                print(f'⚠️ Queue scan error: {e}')
            conn.close()
        except Exception as e:
            print(f'⚠️ Error scanning file: {e}')
            continue
    return issues

def prioritize_issues(issues, known_patterns):
    seen = set()
    unique = []
    for issue in issues:
        key = issue["message"][:80].lower()
        if key not in seen and key not in known_patterns:
            seen.add(key)
            unique.append(issue)
    priority_order = {"test_import_error": 0, "test_regression": 1, "stale_lease": 2, "dead_letter": 3, "overnight_exception": 4, "overnight_error": 5, "api_rate_limit": 6, "overnight_failure": 7, "overnight_timeout": 8, "test_infrastructure": 9}
    unique.sort(key=lambda x: priority_order.get(x["category"], 99))
    return unique

def generate_backlog(issues):
    now = datetime.now().isoformat(timespec="seconds")
    lines = [f"# 🤖 Autonomous Backlog", f"*Generated: {now}*", "", "## Instructions for Aider", "- Pick the **top unchecked** item below", "- Investigate root cause using available context", "- Apply minimal surgical fix", "- Run `python3 tools/quality_gate.py` and relevant tests", "- Change `[ ]` to `[x]` when resolved", "- If unfixable, add to `dashboard_memory.db` fix_patterns and skip", ""]
    if not issues:
        lines += ["## ✅ No Actionable Issues Found", "", "All systems nominal. Consider:", "- Running full test suite for regression check", "- Reviewing 🟢 Low Priority items in TECH_DEBT_REPORT.md", "- Scanning for new optimization opportunities"]
    else:
        lines.append(f"## 🔴 Prioritized Issues ({len(issues)} found)")
        lines.append("")
        labels = {"test_import_error": "🚨 Test Import/Collection Error", "test_regression": "🔴 Test Regression", "stale_lease": "🟠 Stale Queue Lease", "dead_letter": "🟠 Dead-Lettered Queue Item", "overnight_exception": "🟡 Overnight Exception", "overnight_error": "🟡 Overnight Error", "api_rate_limit": "🟡 API Rate Limit Hit", "overnight_failure": "🟡 Overnight Failure", "overnight_timeout": "🟡 Overnight Timeout", "test_infrastructure": "🟢 Test Infrastructure"}
        for issue in issues:
            label = labels.get(issue["category"], issue["category"])
            lines += [f"- [ ] **{label}**", f"  - Message: `{issue['message']}`", f"  - Source: `{issue['file']}`", ""]
    OUTPUT.write_text("\n".join(lines))
    print(f"✅ AUTO_BACKLOG.md generated with {len(issues)} issues")

def main():
    print(f"\n🔍 BACKLOG SCANNER @ {datetime.now().isoformat()}")
    known = get_known_patterns()
    print(f"  Loaded {len(known)} known patterns from memory DB")
    all_issues = []
    print("  Scanning overnight logs...")
    all_issues.extend(scan_overnight_logs())
    print("  Scanning test results...")
    all_issues.extend(scan_test_results())
    print("  Scanning queue state...")
    all_issues.extend(scan_queue_state())
    print(f"  Found {len(all_issues)} raw issues")
    prioritized = prioritize_issues(all_issues, known)
    print(f"  {len(prioritized)} unique actionable issues after dedup")
    generate_backlog(prioritized)

if __name__ == "__main__":
    main()
