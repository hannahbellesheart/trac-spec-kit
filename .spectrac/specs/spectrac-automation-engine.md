# spectrac.tsln — SpecTRAC Solution Manifest
# Project: SpecTRAC Automation Engine
# Version: 1.0.0-alpha
# Author: hannahbellesheart
# Created_at: 2025-10-30T05:00:00Z
# Purpose: Authoritative list of projects within this solution and repository-wide default governance flags.

solution.name: spectrac-automation-solution
solution.id: S-001
description: Solution manifest listing all projects governed by the SpecTRAC workflow. The agent MUST load this file first in a multi-project context.

# === Project Definitions ===
projects:
  - project.name: spectrac-alpha
    project.id: P-001
    path: ./services/spec-agent
    manifest_path: ./services/spec-agent/.spectrac/spectrac-alpha.stp
  - project.name: example-api
    project.id: P-002
    path: ./examples/example-api
    manifest_path: ./examples/example-api/.spectrac/example-api.stp

# === Solution-Level Governance Defaults (Overridable by .stp) ===
fetch_rates_on_generate: true # If true, automatically fetches external rate data
commit_generated_artifacts: true # If true, agent commits artifacts (PR generation)
sync_with_github_issues: true # If true, links tasks/DPs to GitHub Issues
cache_ttl_days: 30 # Default cache lifetime for fetched estimates

# === Global Allowed Sources for Cost/Hours (Overridable by .stp) ===
allowed_rate_sources:
  - https://clutch.co/
  - https://www.goodfirms.co/
  - https://www.upwork.com/
  - https://www.toptal.com/
  # ... and others in the full list
