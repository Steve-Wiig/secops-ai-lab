#!/usr/bin/env python3
"""Mechanical P1 fixer: adds timeouts to network calls, wraps blocking calls."""
import re
import os
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
FIXED_FILES = []

def fix_network_timeouts(filepath):
    """Add timeout=30 to requests/httpx calls missing it."""
    content = filepath.read_text()
    original = content
    
    # requests.get/post/put/delete/patch/head without timeout
    content = re.sub(
        r'(requests\.(get|post|put|delete|patch|head)\([^)]*?)(\))',
        lambda m: m.group(1) + ', timeout=30' + m.group(3) if 'timeout' not in m.group(1) else m.group(0),
        content
    )
    
    # httpx calls without timeout  
    content = re.sub(
        r'(httpx\.(get|post|put|delete|patch)\([^)]*?)(\))',
        lambda m: m.group(1) + ', timeout=30' + m.group(3) if 'timeout' not in m.group(1) else m.group(0),
        content
    )
    
    if content != original:
        filepath.write_text(content)
        return True
    return False

def main():
    print("🔧 MECHANICAL P1 FIXER")
    fixed = 0
    
    for pyfile in ROOT.rglob("*.py"):
        if any(skip in str(pyfile) for skip in ['.git', '__pycache__', 'venv', 'node_modules']):
            continue
        
        if fix_network_timeouts(pyfile):
            rel = pyfile.relative_to(ROOT)
            FIXED_FILES.append(str(rel))
            fixed += 1
            print(f"  ✅ Fixed timeouts: {rel}")
    
    print(f"\n✅ Fixed {fixed} files")
    
    # Now run quality gate to see what remains
    print("\n=== REMAINING ISSUES ===")
    os.system(f"cd {ROOT} && python3 tools/quality_gate.py 2>&1 | tail -20")

if __name__ == "__main__":
    main()
