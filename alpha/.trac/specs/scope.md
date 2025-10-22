# scope.md

Project (placeholder): {project-name-placeholder}
Author: hannahbellesheart
Created: 2025-10-22T12:38:05Z
Purpose: Specification of features, phases, tasks and decision points for the "Spec Automation Engine".

Rate bands (placeholder — agent may use project defaults or fetch citations)
- Low rate: $50/hr
- Standard rate: $120/hr
- High rate: $180/hr

Features (concise)
- F-001: Natural-language → Spec Package
- F-002: .trac Workspace management
- F-003: EARS conversion engine
- F-004: Task planner & ID assignment
- F-005: Logging subsystem
- F-006: Mock server + generation commands
- F-007: CI integration
- F-008: Task execution interface (CLI)
- F-009: Governance & PR checklist generator

Plan Phases (high-level) — each phase MUST include hours (L/S/H), costs (L/S/H), decision point.
Phase 0 — Project Setup & Alignment (D-001)
  - T-001 Create .trac skeleton (1/2/3 hrs) — costs per rate band
  - T-002 Confirm manifest & policies (1/1/2 hrs)
  - Totals L/S/H: compute sum of tasks (agent to fill costs using chosen rates)

Phase 1 — Core Generator (D-002)
  - T-003 NLP parsing & EARS mapping (8/20/40 hrs)
  - T-004 Spec templating engine (6/16/32 hrs)
  - T-005 Artifact writer (.trac/specs) (3/8/16 hrs)
  - Totals: sum tasks (agent to compute costs with rate bands)

Phase 2 — Developer Ergonomics (D-003)
  - T-006 Mock server + example openapi (2/6/12 hrs)
  - T-007 Client generation quickstart (2/6/12 hrs)

Phase 3 — CI & Contract Tests (D-004)
  - T-008 GitHub Actions for lint & validation (3/8/16 hrs)
  - T-009 Contract test configuration (4/12/24 hrs)

Phase 4 — Execution Interface (D-005)
  - T-010 tasks.md CLI (2/6/12 hrs)
  - T-011 Optional web UI (16/40/80 hrs)

Project totals
- Agents MUST compute & populate Project Totals for Hours and Costs in all bands before submission for D-002 approval.

Decision Points
- D-001 Confirm project name, manifest values, commit policy.
- D-002 Approve MVP scope (Phase 0..1).
- D-003 Approve mock server & SDK languages.
- D-004 Approve contract testing approach.
- D-005 Approve Execution Interface scope (CLI vs web UI).

Agent responsibilities
- When producing a new scope.md (first draft), agent must mark all placeholder costs as `PROVISIONAL`.
- If user grants permission to fetch rates, agent must annotate rates with citation references and replace `PROVISIONAL`.
