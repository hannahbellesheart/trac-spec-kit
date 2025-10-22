```text
# structure.md

Repository layout and naming conventions for agents and humans.

Recommended root layout
Root/
  - .trac/
    - {project}.tproj
    - specs/
      - commands.md
      - requirements.md
      - design.md
      - tech.md
      - structure.md
      - scope.md
      - tasks.md
      - openapi.yaml (optional)
    - logs/
      - YYYYMMDD_HHMMSSZ.log
    - api-standards.md
    - testing-standards.md
    - code-conventions.md
    - security-policies.md
    - deployment-workflow.md
  - specs/ (optional public copy)
  - src/
  - tests/
  - docs/

Naming & branch conventions
- kebab-case filenames by default (override allowed in .tproj).
- Feature branch name: feature/spec-F-###-short-desc
- PR title: [spec][F-###] Short description

Task & ID conventions
- F-### for features (prefixed per-project)
- T-### for tasks
- D-### for decision points

Versioning actions
- If a change is non-breaking, increment spec patch (vX.Y.Z).
- For breaking changes, create Decision Point and align on deprecation policy before merge.
```
