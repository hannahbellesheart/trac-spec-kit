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







# structure.md (solution-aware)

This repository supports either:
- Single-project layout (single .spectrac per repo root), OR
- Solution layout (a single .spectrac at repo root used to coordinate multiple projects).

Root layout examples:

Option A — Single Project
Root/
  .spectrac/
    spectrac-alpha.tproj
    specs/
    logs/
  src/
  docs/

Option B — Solution (multiple projects; one .spectrac at repo root)
Root/
  spectrac.tsln              # solution manifest (required for multiple projects)
  .spectrac/
    solution/
      summary.md
      scope.md
    logs/
  services/
    spec-agent/
      .spectrac/
        spectrac-alpha.tproj
        specs/
        logs/
    example-api/
      .spectrac/
        example-api.tproj
        specs/
        logs/
  docs/
  src/

Rules
- If `spectrac.tsln` exists, the repository is a solution repository. Agents must not assume a single project.
- Per-project manifests and artifacts MUST live in the per-project **`.spectrac/`** directory as referenced in spectrac.tsln.
- Agents should treat `spectrac.tsln` as authoritative for enumeration and solution-level flags.

... (rest of the file unchanged)
