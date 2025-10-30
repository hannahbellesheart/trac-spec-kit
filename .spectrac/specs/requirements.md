# requirements.md (EARS-style)

Source: user directive ({timestamp}) — Principal EA: hannahbellesheart
Format: EACH requirement MUST be one EARS statement with acceptance criteria and traceable Feature ID (see directives.md Section 3.1).

INSTRUCTIONS FOR AGENTS:
- For every natural-language prompt, extract functional and non-functional requirements and write them in EARS.

F-### — {Short Feature Description} (P0/P1/P2)
WHEN {triggering condition},
THE SYSTEM SHALL {required system response}.
Acceptance criteria:
  - GIVEN {precondition}, WHEN {trigger}, THEN {testable outcome}.
  - {further criteria}
Trace to tasks: {T-###, T-###}

---
# NON-FUNCTIONAL REQUIREMENTS
F-NF-001 — {NF Requirement Title} (P0)
WHEN {trigger},
THE SYSTEM SHALL {enforce condition}.
Acceptance criteria:
  - {NF criteria}
