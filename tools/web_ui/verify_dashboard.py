"""
SELF-VERIFICATION PROTOCOL:
- Run BEFORE any dashboard commit
- Tests all 5 API endpoints for correct JSON responses
- Logs results to dashboard_memory.db
- If any test fails, fix and re-run before committing
"""
import requests
import json
import sqlite3
import subprocess
from datetime import datetime

DB_PATH = "tools/web_ui/dashboard_memory.db"
BASE_URL = "http://localhost:8000"

def log_result(test_name, passed, details=""):
    commit = subprocess.run(["git", "rev-parse", "--short", "HEAD"],
                          capture_output=True, text=True).stdout.strip()
    conn = sqlite3.connect(DB_PATH)
    conn.execute("INSERT INTO test_results (test_name, passed, details, commit_hash) VALUES (?, ?, ?, ?)",
                (test_name, passed, details, commit))
    conn.commit()
    conn.close()
    status = "✅ PASS" if passed else "❌ FAIL"
    print(f"{status}: {test_name}" + (f" - {details}" if details else ""))

def verify_all():
    print(f"\n=== DASHBOARD VERIFICATION @ {datetime.now().isoformat()} ===\n")
    tests = [
        ("root_html_served", lambda: _test_root()),
        ("api_logs_json", lambda: _test_logs()),
        ("api_system_status", lambda: _test_system_status()),
        ("api_live_activity_json", lambda: _test_live_activity()),
        ("api_settings_get", lambda: _test_settings()),
    ]
    for name, fn in tests:
        try:
            fn()
        except Exception as e:
            log_result(name, False, str(e))
    print("\n=== VERIFICATION COMPLETE ===\n")

def _test_root():
    r = requests.get(BASE_URL, timeout=5)
    has_banner = "VERSION" in r.text and ("3.5" in r.text or "3.7" in r.text)
    is_html = r.text.strip().startswith("<!DOCTYPE html>")
    log_result("root_html_served", is_html and has_banner,
               f"Status={r.status_code}, Banner={'Yes' if has_banner else 'No'}")

def _test_logs():
    r = requests.get(f"{BASE_URL}/api/logs?lines=5", timeout=5)
    is_json = r.headers.get("content-type", "").startswith("application/json")
    data = r.json() if is_json else None
    valid = isinstance(data, (list, dict)) and ("logs" in data or "lines" in data or isinstance(data, list))
    log_result("api_logs_json", is_json and valid,
               f"Content-Type={r.headers.get('content-type')}")

def _test_system_status():
    r = requests.get(f"{BASE_URL}/api/system-status", timeout=5)
    data = r.json()
    required = ["queues", "workers", "backlog", "processes"]
    missing = [k for k in required if k not in data]
    log_result("api_system_status", len(missing) == 0,
               f"Missing: {missing}" if missing else "All keys present")

def _test_live_activity():
    r = requests.get(f"{BASE_URL}/api/live-activity", timeout=5)
    is_json = r.headers.get("content-type", "").startswith("application/json")
    log_result("api_live_activity_json", is_json, f"Content-Type={r.headers.get('content-type')}")

def _test_settings():
    r = requests.get(f"{BASE_URL}/api/settings", timeout=5)
    is_json = r.headers.get("content-type", "").startswith("application/json")
    log_result("api_settings_get", is_json, f"Content-Type={r.headers.get('content-type')}")

if __name__ == "__main__":
    verify_all()
