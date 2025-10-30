# structure.md (Solution-Aware)

This repository supports either:
- Single-project layout (single .spectrac per repo root), OR
- Solution layout (a single spectrac.tsln at repo root to coordinate multiple projects). (See directives.md Section 4.1).

## Root Layout Examples

Option A — Single Project
Root/
  .spectrac/
    spectrac.stp
    specs/
    logs/

Option B — Solution (Authoritative)
Root/
  spectrac.tsln             # Solution manifest
  .spectrac/                # Solution-level artifacts (logs, solution scope)
  services/
    project-a/
      .spectrac/            # Project-level artifacts (project-a.stp, project-a/specs)
    project-b/
      .spectrac/

## Naming & ID Conventions (Mandatory)
- Project IDs: P-###
- Feature IDs: {P-ID}-F-###
- Task IDs: {P-ID}-T-###
- Decision Points: {P-ID}-D-### (Project) or D-SOL-### (Solution)
