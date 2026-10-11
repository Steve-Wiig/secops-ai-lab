#!/usr/bin/env python3
"""Smart Context Loader: auto-selects relevant files for Aider based on top backlog item."""
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
BACKLOG = ROOT / "AUTO_BACKLOG.md"


def get_top_unchecked():
    if not BACKLOG.exists():
        return None, None, None
    lines = BACKLOG.read_text().splitlines()
    in_issues = False
    for i, line in enumerate(lines):
        if "Prioritized Issues" in line or "Actionable Issues" in line:
            in_issues = True
            continue
        if in_issues and line.strip().startswith("- [ ]"):
            label_match = re.search(r'\*\*(.+?)\*\*', line)
            label = label_match.group(1) if label_match else "Unknown"
            msg, src = "", ""
            for j in range(i + 1, min(i + 5, len(lines))):
                if "Message:" in lines[j]:
                    m = re.search(r'Message:\s*`(.+?)`', lines[j])
                    msg = m.group(1) if m else ""
                if "Source:" in lines[j]:
                    s = re.search(r'Source:\s*`(.+?)`', lines[j])
                    src = s.group(1) if s else ""
            return label, msg, src
    return None, None, None


def _is_real_file(rel_path):
    """Check if a relative path points to an actual file (not directory)."""
    p = ROOT / rel_path
    return p.exists() and p.is_file()


def find_relevant_files(label, msg, src):
    candidates = set()

    # Signal 1: Source file (must be a file, not directory)
    if src and src != "tests/" and not src.endswith("/"):
        if _is_real_file(src):
            candidates.add(src)

    # Signal 2: File paths in message
    path_pattern = re.compile(r'(?:^|[\s`])([\w./\-]+\.py)(?:[\s`]|$)')
    for match in path_pattern.finditer(msg or ""):
        rel = match.group(1)
        if _is_real_file(rel):
            candidates.add(rel)

    # Signal 3: Module keyword mapping
    keywords = re.findall(r'[A-Za-z_]{4,}', (msg or "") + " " + (label or ""))
    mapping = {
        "queue": ["engine/queue_manager.py", "engine/strict_queue_transitions.py"],
        "worker": ["engine/aider_development_worker.py", "engine/slm_triage_worker.py"],
        "patcher": ["engine/multi_file_patcher.py", "engine/patch_parser.py"],
        "enrichment": ["engine/alert_enrichment.py", "engine/enrichment_scheduler.py"],
        "intake": ["engine/intake_wazuh.py", "engine/intake_eve.py"],
        "writeback": ["engine/writeback/wazuh_proposals.py", "engine/writeback/pfsense_alias.py"],
        "ledger": ["engine/quota_ledger.py", "engine/reasoning_ledger.py"],
        "consumer": ["edge/pi_consumer.py"],
        "server": ["tools/web_ui/server.py"],
        "scanner": ["tools/backlog_scanner.py"],
        "model_registry": ["engine/model_registry.py", "orchestrator/model_registry.py"],
        "backpressure": ["tools/queue_backpressure_check.py"],
        "retention": ["memory/retention.py"],
    }
    for kw in set(keywords):
        for key, files in mapping.items():
            if key in kw.lower():
                for f in files:
                    if _is_real_file(f):
                        candidates.add(f)

    # Signal 4: Matching test files
    for c in list(candidates):
        stem = Path(c).stem
        test_path = ROOT / "tests" / f"test_{stem}.py"
        if test_path.exists() and test_path.is_file():
            candidates.add(f"tests/test_{stem}.py")

    # HARD FILTER: only real files, exclude AUTO_BACKLOG.md and any directory
    return sorted([
        f for f in candidates
        if _is_real_file(f)
        and f != "AUTO_BACKLOG.md"
        and not f.endswith("/")
    ])


def main():
    label, msg, src = get_top_unchecked()
    if not label:
        print("# ✅ No unchecked issues in AUTO_BACKLOG.md")
        return

    print(f"# 🎯 Top Issue: {label}")
    print(f"# 📝 Message: {msg[:100]}...")
    print(f"# 📄 Source: {src}\n")

    files = find_relevant_files(label, msg, src)

    if not files:
        print("# ⚠️ No relevant files found, skipping")
        return

    print(f"# 📦 {len(files)} relevant files selected:")
    for f in files:
        print(f"#    - {f}")

    cmd = "aider --read AUTO_BACKLOG.md " + " ".join(files)
    print(f"\n# ▶️  Run this command:")
    print(cmd)


if __name__ == "__main__":
    main()
