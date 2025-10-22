project.name: trac-spec-alpha
project.id: P-001
author: hannahbellesheart
created_at: 2025-10-22T14:39:00Z
specs_path: .trac/specs/
logs_path: .trac/logs/

# Controls whether an agent is allowed to perform live network lookups for rate/estimate data
fetch_rates_on_generate: true

allowed_rate_sources:
  - https://clutch.co/
  - https://www.goodfirms.co/
  - https://www.upwork.com/
  - https://www.toptal.com/
  - https://www.freelancer.com/
  - https://www.glassdoor.com/
  - https://www.indeed.com/
  - https://www.linkedin.com/salary/
  - https://www.roberthalf.com/
  - https://insights.stackoverflow.com/survey

# Whether generated artifacts may be committed to repo by the agent
# true = agent may create branches and PRs with generated artifacts (must follow PR rules)
commit_generated_artifacts: true

# Whether agent should create/sync GitHub Issues for tasks
sync_with_github_issues: true

# Preferred SDK languages: empty for now; agent will prompt on first run if empty
preferred_sdk_languages: []

# Rate fallback (provisional) used if lookups fail or network disabled
rates:
  low: 50
  standard: 120
  high: 180

# Cache TTL for fetched rate data (days)
cache_ttl_days: 30

notes: |
  - Replace project.name with canonical name when decided by Principal EA.
  - Any change to fetch_rates_on_generate or allowed_rate_sources must be recorded as Decision Point D-### and logged.
  - Agents must append a session log entry whenever they fetch external data and include fetched URLs and timestamps.
