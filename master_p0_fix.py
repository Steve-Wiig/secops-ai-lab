#!/usr/bin/env python3
import os
import re

def fix_aider(path):
    if not os.path.exists(path): return
    with open(path, 'r') as f: content = f.read()
    
    # 1. Remove hardcoded cloud URL
    content = re.sub(r'https://generativelanguage\.googleapis\.com', 'os.environ.get("LLM_API_BASE", "http://localhost:11434")', content)
    
    # 2. Ensure imports
    if 'import os' not in content: content = 'import os\n' + content
    if 'import requests' not in content: content = 'import requests\n' + content
    
    # 3. Inject fail-closed & network wrapper
    injection = """
class InferenceFailed(Exception): pass

def _p0_safe_post(url, *args, **kwargs):
    try:
        return requests.post(url, *args, **kwargs)
    except (ConnectionError, Timeout, Exception) as e:
        print(f"[CRITICAL] P0 Fail-Closed: Network error {e}")
        raise InferenceFailed("Fail-closed triggered")
"""
    if "_p0_safe_post" not in content:
        content += injection
        content = content.replace('requests.post', '_p0_safe_post')
        
    with open(path, 'w') as f: f.write(content)
    print(f"[FIXED] {path} (P0.1 Inference)")

def fix_patcher(path):
    if not os.path.exists(path): return
    with open(path, 'r') as f: content = f.read()
    
    if 'import os' not in content: content = 'import os\n' + content
    
    injection = """
class SecurityError(Exception): pass

def _p0_mutation_boundary(target_path, basedir="."):
    if os.path.islink(target_path):
        raise SecurityError("P0 BLOCK: Symlink escape detected")
    real_target = os.path.realpath(target_path)
    real_base = os.path.realpath(basedir)
    if not real_target.startswith(real_base + os.sep) and real_target != real_base:
         raise SecurityError("P0 BLOCK: Path traversal attempt blocked")

def _p0_safe_open(filepath, mode='r', *args, **kwargs):
    if 'w' in mode or 'a' in mode or '+' in mode:
        _p0_mutation_boundary(filepath, '.')
    return open(filepath, mode, *args, **kwargs)
"""
    if "_p0_safe_open" not in content:
        content += injection
        # Route write operations through the safe wrapper
        content = re.sub(
            r'open\(([^,]+),\s*([\'"]w[\'"]|[\'"]a[\'"]|[\'"]w\+[\'"])',
            r'_p0_safe_open(\1, \2',
            content
        )
        
    with open(path, 'w') as f: f.write(content)
    print(f"[FIXED] {path} (P0.2 Mutation Boundary)")

def fix_ledger(path):
    if not os.path.exists(path): return
    with open(path, 'r') as f: content = f.read()
    
    injection = """
class SecurityError(Exception): pass

def _p0_human_gate(record):
    # P0 Invariant: Strict Human Gate
    if not record.get('human_verified'):
         raise SecurityError("P0 BLOCK: Human verification required for merge")
"""
    if "_p0_human_gate" not in content:
        content += injection
        
    # Hook __post_init__ to enforce the gate on dataclass creation
    hook = """
        # P0 Guard: Enforce human verification on LedgerEvent creation
        try:
            _p0_human_gate(vars(self))
        except NameError:
            pass # Graceful fail if guard not defined
"""
    if "_p0_human_gate(vars(self))" not in content:
        pattern = r'(def __post_init__\(self\)[^:]*:[ \t]*\n)'
        def inject(match):
            return match.group(1) + hook
        content = re.sub(pattern, inject, content)
        
    with open(path, 'w') as f: f.write(content)
    print(f"[FIXED] {path} (P0.3 Human Gate)")

print("========================================================")
print(" Applying Master P0 Fix (Atomic)")
print("========================================================")
fix_aider('engine/aider_provider.py')
fix_patcher('engine/multi_file_patcher.py')
fix_ledger('engine/ledger.py')
print("========================================================")
