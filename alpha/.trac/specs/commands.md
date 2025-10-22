```text
# commands.md (updated: solution-aware rules)

Purpose
- Authoritative agent rules and guardrails. This file now includes solution-aware behavior when multiple projects live under a single repository root with one .trac workspace.

Top-level behavior
- On start, agent MUST check for .trac/trac.tsln. If present, treat repository as a "solution".
- Agent MUST then enumerate `projects[]` from trac.tsln and:
  - If user prompt references a specific project path or name, target that project (load its .tproj).
  - If user prompt does NOT specify a project, agent MUST prompt the user to pick one of:
    - Single project (interactive selection)
    - "All projects" (agent will generate per-project artifacts)
    - "Create new project" (agent will scaffold a new project and its .tproj)
- Agents MUST NOT assume a single project when trac.tsln exists.

Project & ID scoping (ensuring global uniqueness)
- Each project keeps its own project.id (e.g., P-001). IDs are scoped to a project.
- Global IDs MUST include the project id prefix to preserve uniqueness in solution contexts:
  - Feature ID format: {project_id}-F-### (example: P-002-F-005)
  - Task ID format: {project_id}-T-### (example: P-002-T-012)
  - Decision Point: {project_id}-D-### or solution-level D-### for cross-project decisions
- Agents MUST always include `project_id` in the front-matter or header of any generated file when operating in a solution context.

File & path placement rules
- Per-project manifests remain in each project folder at: {project}/.trac/{project}.tproj
- Per-project spec artifacts go to: {project}/.trac/specs/
- Solution-level artifacts (if produced) should go in .trac/ under a `solution/` subfolder:
  - .trac/solution/summary.md
  - .trac/solution/scope.md (aggregated per-project totals)
- Logs:
  - Per-project logs: {project}/.trac/logs/YYYYMMDD_HHMMSSZ.log
  - Solution-level logs: .trac/logs/YYYYMMDD_HHMMSSZ.log (must reference project ids affected)
- Agents must never concurrently write to the same log file from multiple projects; use per-project logs plus an append-only solution log for cross-project operations.

Estimate, caching & fetch behavior
- Agents must read per-project `.tproj` flags (fetch_rates_on_generate, allowed_rate_sources, cache_ttl_days). Per-project values override solution defaults.
- When generating solution-wide scope (All projects), agent must:
  - Fetch estimates per project (respecting each project's `.tproj` settings).
  - Produce both per-project L/S/H hours and costs and a solution total that sums them.
  - Append a solution-level `ACTION=ESTIMATE-CALC` log entry summarizing which source URLs were used per project.

Decision Points & cross-project changes
- If a requested change affects >1 project or shared/public API used by multiple projects, agent MUST create a solution-level Decision Point (D-SOL-###) and block auto-merge of generated commits until Principal EA approves.
- Per-project Decision Points remain {project_id}-D-###.

GitHub Issues sync & PR generation
- When sync_with_github_issues=true at solution or project level:
  - For per-project tasks: create Issues with label `spec-task` + project-id label (e.g., `P-002`).
  - For solution-level tasks or cross-project Decision Points: create a solution-level Issue labeled `spec-solution`.
- Branching:
  - Per-project generated branches: `{project}/feature/generated-{project_id}-F-###-short-desc`
  - Solution-wide generated branches (if creating many per-project changes): `solution/feature/generated-S-001-<short>`

Logging & audit
- Per-project logs must include `project_id` and `solution_id` when applicable:
  - Example JSONL log entry (per-project):
    { "ts":"2025-10-22T15:00:00Z", "action":"CREATE", "agent":"spec-agent", "project_id":"P-001", "files":[".trac/specs/requirements.md"], "ids":["P-001-F-001"], "notes": "..." }
  - Example solution log entry:
    { "ts":"2025-10-22T15:02:00Z", "action":"ESTIMATE-CALC", "agent":"spec-agent", "solution_id":"S-001", "project_breakdown":[{"project_id":"P-001","sources":[...],"hours":{...},"cost":{...}}] }

Agent UX for multi-project prompts
- If prompt is ambiguous about target project, agent should:
  1. Attempt to infer project from prompt (search for project names/paths).
  2. If inference fails or confidence < 0.6, ask the user to select the project or choose `All projects`.
  3. Provide a short summary of implications (e.g., "Generating for all projects will produce N PRs; estimated total time is ...").

Guardrails recap for solutions
- Never overwrite per-project artifacts. Agent must create .vN revisions or new branches for edits.
- Cross-project breaking changes require solution Decision Point (D-SOL-###).
- Agents must preserve global ID uniqueness by using project prefix.

Example agent flow for "All projects" generation
- Read .trac/trac.tsln → enumerate projects
- For each project:
  - Read project .tproj
  - Generate per-project .trac/specs artifacts and per-project logs
  - Compute estimates (using per-project allowed sources)
  - Create per-project branches and PRs with `[generated]` marker
- Produce .trac/solution/summary.md that aggregates phase totals and includes a breakdown by project

```
