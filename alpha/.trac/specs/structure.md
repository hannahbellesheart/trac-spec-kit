```text
# structure.md (solution-aware)

This repository supports either:
- Single-project layout (single .trac per repo root), OR
- Solution layout (a single .trac at repo root used to coordinate multiple projects).

Root layout examples:

Option A — Single Project
Root/
  .trac/
    trac-spec-alpha.tproj
    specs/
    logs/
  src/
  docs/

Option B — Solution (multiple projects; one .trac at repo root)
Root/
  .trac/
    trac.tsln                # solution manifest (required for multiple projects)
    solution/
      summary.md
      scope.md
    logs/
  services/
    spec-agent/
      .trac/
        trac-spec-alpha.tproj
        specs/
        logs/
    example-api/
      .trac/
        example-api.tproj
        specs/
        logs/
  docs/
  src/

Rules
- If `.trac/trac.tsln` exists, the repository is a solution repository. Agents must not assume a single project.
- Per-project manifests and artifacts MUST live in the per-project `.trac/` directory as referenced in trac.tsln.
- Agents should treat `.trac/trac.tsln` as authoritative for enumeration and solution-level flags.

Naming & ID conventions (reminder)
- Project IDs: P-001, P-002...
- Feature IDs: {project_id}-F-###
- Task IDs: {project_id}-T-###
- Decision Points: {project_id}-D-### (or D-SOL-### for solution-level)

Tasks & Issues mapping
- Tasks created for a project must map to GitHub Issues using the project label (project-id) for easy filtering.
- Solution-level Decision Points should be surfaced with `spec-solution` label.

Per-project vs solution-level logs
- Keep per-project logs small and focused.
- Use .trac/logs (solution) for cross-project events, aggregated summaries, or solution Decision Points.
```
