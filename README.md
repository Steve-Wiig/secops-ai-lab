# Local-First Security Workflow Research

An independent, in-progress project exploring practical safeguards for LLM-assisted security analysis and software development.

> **Status: Active development.** This repository is an experimental engineering project, not a production-ready security platform. The current focus is improving the development workflow with Aider and experimenting with a local LLM review swarm while continuing to test and harden the underlying code.

## Purpose

The project explores how language models can assist with security-event triage and routine engineering tasks while keeping authority in code, explicit policy, tests, and human review.

The guiding principle is:

**A model can suggest. Code and policy validate. Actions stay bounded. Evidence is recorded. People remain accountable.**

This is an independent project focused on general patterns for structured recommendations, validation, trust boundaries, and controlled workflow automation. It is not intended to reproduce, emulate, reverse-engineer, or replace any commercial security product.

## Work represented in the codebase

The repository contains experimental components and tests covering areas such as:

- **Event handling and contracts:** Normalizing security-event data and using typed recommendation structures to make inputs and outputs easier to validate.
- **LLM-assisted triage:** Worker and model-selection components intended to support analysis of normalized events. Model output is treated as untrusted input, not authorization to act.
- **Policy and safety checks:** Deterministic validation and explicit gates between a recommendation and any permitted follow-up action.
- **Queue and lifecycle handling:** Redis-backed work queues and constrained state transitions intended to make processing status more explicit and auditable.
- **Bounded writeback and integrity controls:** Safeguards around changes or responses, including validation of worker/job data and patch handling in relevant development workflows.
- **Tests and verification:** Pytest-based tests for contracts, safety checks, lifecycle behavior, and other individual components.

These are areas of implementation and experimentation, not a claim that every component is fully integrated or validated as one end-to-end production system. Check the current code and run the relevant tests before relying on a particular behavior.

## Current development focus

### Aider and LLM-assisted coding

A current priority is learning to use Aider effectively for focused coding tasks: defining a narrow change, inspecting the proposed diff, running relevant tests, reviewing failures, and keeping changes manageable. The goal is not to accept generated code automatically, but to develop a repeatable process for evaluating and improving it.

### Local LLM review swarm

The project also experiments with multiple local-model workers to review code, identify possible defects, suggest tests, and surface improvement opportunities. This workflow is still being refined. Swarm findings are advisory and can be incomplete or incorrect; they do not replace testing or human review.

### Engineering reliability

Ongoing work includes strengthening validation, tests, error handling, state transitions, integrity checks, auditability, and the distinction between a proposed change, a tested change, and a change that has actually been accepted. The repository and its workflows continue to evolve as these experiments reveal gaps.

## Tools and technologies

Tools and technologies used or explored across the codebase and development workflow include:

- **Languages and testing:** Python, pytest
- **Contracts and data validation:** Pydantic-style typed models and schema validation
- **Queueing and workflow state:** Redis
- **Version control:** Git and GitHub
- **AI-assisted development:** Aider / Aider Desk experiments
- **Local-model experimentation:** Ollama and Qwen-family models, including multi-worker review experiments
- **Development model-provider experiments:** Provider routing through services such as OpenRouter and Gemini where configured; these are development-tooling choices, not a claim that every inference path is local
- **Security monitoring tools and context:** Wazuh and Security Onion

Listing a tool means it has been used or explored in the broader project/development context; it does not imply a complete, supported integration with every version or deployment of that tool. The project is centered on general security-event handling and safe automation patterns, not on duplicating any vendor-specific platform.

## Design principles

- **Human authority:** Model output cannot approve itself or make itself trustworthy.
- **Deterministic enforcement:** Permissions and consequential decisions belong in explicit application logic and policy checks.
- **Bounded actions:** Any write or response capability should be narrow in scope and checked before use.
- **Fail safely:** Invalid output, failed validation, or unavailable dependencies should not silently grant more authority.
- **Traceability:** Record relevant decisions and outcomes so they can be inspected where practical.
- **Incremental changes:** Prefer small, reviewable edits and relevant tests over unreviewed bulk changes.
- **Evidence over claims:** Distinguish implemented behavior from planned work, experiments, and assumptions.

## Status and limitations

- The project is **work in progress** and is not presented as a supported, drop-in security product.
- It is **not a production-deployed autonomous SOC** and should not be used for unattended incident response.
- Some components are experimental or are being evaluated independently; end-to-end behavior and operational readiness should not be assumed.
- A passing test suite only demonstrates the cases covered by those tests. It does not prove complete security, reliability, or effectiveness against real-world threats.
- Development-agent and local-model workflows may behave differently as models, prompts, dependencies, and configuration change.

## Repository guide

Useful starting points in the repository include:

- [`engine/`](./engine/) — processing and workflow components
- [`contracts/`](./contracts/) — structured data contracts
- [`overnight/`](./overnight/) — experimental development and improvement workflow code
- [`tests/`](./tests/) — automated tests
- [`ARCHITECTURE.md`](./ARCHITECTURE.md) — architecture notes
- [`SECURITY.md`](./SECURITY.md) — security policy and reporting guidance
- [`VALIDATION_REPORT.md`](./VALIDATION_REPORT.md) — a dated validation and hardening snapshot; review its date and claims against the current code
- [`LOCAL_GPU_SETUP.md`](./LOCAL_GPU_SETUP.md) — local-model setup notes

Documentation can lag behind implementation while the project is evolving. Treat code, tests, configuration, and dated validation evidence as the basis for assessing any specific capability.

## Independence

This is an independently developed learning and engineering project. It is not affiliated with, endorsed by, or intended as a reconstruction or substitute for any commercial security-vendor product.
