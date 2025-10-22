<#
  PowerShell skeleton for trac task operations and bootstrapping.
  Replace placeholders with concrete implementation or agent endpoint calls.
#>

Param(
  [string]$ProjectManifest = ".trac/trac-spec-alpha.tproj",
  [string]$Command,
  [string]$TaskId,
  [string]$User = $env:USERNAME
)

function Read-Manifest {
  param($path)
  if (-Not (Test-Path $path)) { Write-Error "Manifest not found: $path"; exit 1 }
  return Get-Content $path -Raw
}

function List-Tasks {
  $tasksPath = ".\ .trac\specs\tasks.md"
  if (-Not (Test-Path ".\ .trac\specs\tasks.md")) { Write-Output "No tasks.md found"; return }
  Get-Content ".\ .trac\specs\tasks.md" | Select-String "^- T-" -Context 0,2
}

function Start-Task {
  param($id,$user)
  # Update tasks.md (simple append or modify) and write log entry
  $ts = (Get-Date).ToUniversalTime().ToString("s") + "Z"
  $log = @{
    ts = $ts
    action = "TASK-UPDATE"
    agent = "local-cli"
    user = $user
    project_id = "P-001"
    entries = @{
      task_update = @{
        task_id = $id
        status = "in-progress"
        user = $user
        timestamp = $ts
      }
    }
  } | ConvertTo-Json -Depth 10
  $logFile = ".trac/logs/$(Get-Date -Format 'yyyyMMdd_HHmmss')Z.log"
  $log | Out-File -FilePath $logFile -Encoding utf8 -Append
  Write-Output "Task $id marked in-progress. Log appended to $logFile"
}

function Complete-Task {
  param($id,$user)
  $ts = (Get-Date).ToUniversalTime().ToString("s") + "Z"
  $log = @{
    ts = $ts
    action = "TASK-UPDATE"
    agent = "local-cli"
    user = $user
    project_id = "P-001"
    entries = @{
      task_update = @{
        task_id = $id
        status = "done"
        user = $user
        timestamp = $ts
      }
    }
  } | ConvertTo-Json -Depth 10
  $logFile = ".trac/logs/$(Get-Date -Format 'yyyyMMdd_HHmmss')Z.log"
  $log | Out-File -FilePath $logFile -Encoding utf8 -Append
  Write-Output "Task $id marked done. Log appended to $logFile"
}

switch ($Command) {
  "list" { List-Tasks }
  "start" { Start-Task -id $TaskId -user $User }
  "complete" { Complete-Task -id $TaskId -user $User }
  default {
    Write-Output "Usage: pwsh ./scripts/trac.ps1 -Command list|start|complete -TaskId T-001 -User <name>"
  }
}
