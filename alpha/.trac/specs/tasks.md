# tasks.md - Task tracker template (agent-ready)

Project manifest: {project-name-placeholder}.tproj
Created: 2025-10-22T12:38:05Z

Columns: id | title | feature | phase | estimate (low/standard/high hrs) | cost (L/S/H) | assignee | status | dependencies | notes

Example entries (agents must fill cost columns using project rates and compute phase/project totals):

- T-001 | Create .trac structure and initial files | F-002 | Phase 0 | 1 / 2 / 3 | $<L> / $<S> / $<H> | <assignee> | todo | - | initial scaffold
- T-002 | Confirm project name, SDK languages, artifact commit policy | F-002 | Phase 0 | 1 / 1 / 2 | $<L> / $<S> / $<H> | <assignee> | todo | - | Decision Point D-001
- T-003 | Implement NLP parsing + EARS mapping | F-001/F-003 | Phase 1 | 8 / 20 / 40 | $<L> / $<S> / $<H> | <assignee> | todo | T-002 | core functionality

Phase totals (agents must compute and populate)
- Phase 0 totals: Hours L/S/H = X / Y / Z — Cost L/S/H = $A / $B / $C
- Phase 1 totals: ...

Project totals (agents must compute and populate)
- Hours L/S/H: sum of phases
- Cost L/S/H: sum of phases

Agent actions for updating tasks
- To mark a task in-progress: update status, append a log entry in .trac/logs with `ACTION=TASK-UPDATE` containing id, user, timestamp, and status.
- To complete a task: update status to `done`, add `completed_at` timestamp, and append a log entry with any artifacts produced.
- All status changes must be human-readable in the markdown and structured in the log.

Execution helpers (powershell examples)
- Run mock server (Prism):
  pwsh -c "prism mock .trac/specs/openapi.yaml"
- Generate TypeScript client:
  pwsh -c "openapi-generator-cli generate -i .trac/specs/openapi.yaml -g typescript-axios -o client/typescript"

Notes
- Agents must not change the ID scheme or overwrite existing IDs.
- If adding tasks, pick the next numeric unused T-###.
