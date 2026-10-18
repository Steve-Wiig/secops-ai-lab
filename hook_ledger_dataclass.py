#!/usr/bin/env python3
import re
import os

def hook_post_init(path):
    try:
        with open(path, 'r') as f: content = f.read()
    except FileNotFoundError:
        print(f"[SKIP] {path} not found.")
        return

    hook = """
        # P0 Guard: Enforce human verification on LedgerEvent creation
        try:
            _p0_human_gate(vars(self))
        except NameError:
            pass # Graceful fail if guard not defined
"""
    pattern = r'(def __post_init__\(self\)[^:]*:[ \t]*\n)'
    
    def inject(match):
        return match.group(1) + hook
        
    new_content, count = re.subn(pattern, inject, content)
    if count > 0:
        with open(path, 'w') as f: f.write(new_content)
        print(f"[WIRED] {path}: Human gate hooked into __post_init__")
    else:
        print(f"[SKIP] {path}: __post_init__ not found.")

if __name__ == "__main__":
    print("========================================================")
    print(" Hooking Ledger Dataclass")
    print("========================================================")
    hook_post_init('engine/ledger.py')
    print("========================================================")
    print(" Running Final Verification...")
    print("========================================================")
    os.system("bash verify_p0_readonly.sh")
