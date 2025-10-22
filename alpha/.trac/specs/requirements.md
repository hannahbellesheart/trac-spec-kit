```text
# requirements.md (EARS-style)

Source: user directive (2025-10-22) — Principal EA: hannahbellesheart
Format: EACH requirement MUST be one EARS statement with acceptance criteria and traceable Feature ID.

INSTRUCTIONS FOR AGENTS:
- For every natural-language prompt, extract functional and non-functional requirements and write them in EARS.
- For each requirement, include:
  - Feature ID (F-###)
  - Priority (P0/P1/P2)
  - Acceptance criteria (as bullets)
  - Trace to tasks (T-###) when tasks are generated

EXAMPLE REQUIREMENTS:

F-001 — Natural-language to Spec Package conversion (P0)
WHEN an architect or developer submits a natural-language prompt describing a feature or change,
THE SYSTEM SHALL produce a spec package containing:
  - requirements.md (EARS)
  - design.md (architecture + sequence diagrams)
  - scope.md (features, phases, tasks)
  - tasks.md (task tracker entries)
Acceptance criteria:
  - GIVEN a valid NL prompt, WHEN the agent runs, THEN the .trac/specs files exist and pass Spectral lint (where applicable).
  - GIVEN an update prompt, WHEN the agent generates diffs, THEN a log entry is appended and affected IDs are annotated.

F-002 — .trac Workspace management (P0)
WHEN a new project manifest is created,
THE SYSTEM SHALL create .trac/{project}.tproj and initialize .trac/specs/* and .trac/logs/* with a session log.
Acceptance criteria:
  - Files present with correct manifest fields and no secrets in files.
  - Log includes session-start entry.

F-003 — EARS conversion engine (P0)
WHEN requirements text is present,
THE SYSTEM SHALL convert each requirement into EARS notation and assign Feature IDs.
Acceptance criteria:
  - All functional behaviors expressed as WHEN/THE SYSTEM SHALL statements.
  - Each EARS requirement has at least one acceptance criterion.

F-004 — Task planner & ID assignment (P0)
WHEN features are identified,
THE SYSTEM SHALL produce tasks with unique Task IDs (T-XXX), estimate bands (L/S/H), and dependencies.
Acceptance criteria:
  - Each task has L/S/H hours and L/S/H cost (or placeholder if external cost fetch pending).
  - Project totals computed and present in scope.md.

NON-FUNCTIONAL REQUIREMENTS (examples)
F-NF-001 — Auditability (P0)
WHEN any artifact is generated or modified,
THE SYSTEM SHALL append a structured log entry to .trac/logs and include user, timestamp, action, and affected IDs.

F-NF-002 — Safety (P0)
WHEN generating files, 
THE SYSTEM SHALL avoid writing secrets or PII and shall redact any suspect content in logs.

(Agents: append further requirements following this pattern. Keep every requirement short and testable.)
```
