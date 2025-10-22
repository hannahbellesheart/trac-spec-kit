# Quickstart for junior dev (run local & get productive)

1) Install tooling (PowerShell on Windows or cross-platform pwsh)
2) Run mock server (Prism)
   pwsh -c "pwsh -Command 'prism mock .trac/specs/openapi.yaml'"

3) Generate TypeScript client (example)
   pwsh -c "pwsh -Command 'openapi-generator-cli generate -i .trac/specs/openapi.yaml -g typescript-axios -o client/typescript'"

4) List tasks
   pwsh -c "pwsh ./scripts/trac.ps1 -Command list"

5) Start a task (mark in-progress)
   pwsh -c "pwsh ./scripts/trac.ps1 -Command start -TaskId P-001-T-003 -User yourname"

6) Complete a task
   pwsh -c "pwsh ./scripts/trac.ps1 -Command complete -TaskId P-001-T-003 -User yourname"

7) Where to look:
   - .trac/{project}/specs/requirements.md (EARS)
   - .trac/{project}/specs/scope.md (features & estimates)
   - .trac/{project}/specs/tasks.md (task tracker)
   - .trac/{project}/logs/ (structured JSONL logs)
