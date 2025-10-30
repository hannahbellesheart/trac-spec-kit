# scope.md

Project: {project-name-placeholder} ({project-id})
Author: hannahbellesheart
Created: {timestamp}
Purpose: Specification of features, phases, tasks and decision points. (See directives.md Section 3.3 for full rules).

Rate bands (Final rates from .stp)
- Low rate: ${low-rate}/hr
- Standard rate: ${standard-rate}/hr
- High rate: ${high-rate}/hr

Features (concise)
- F-###: {Feature Title}
- F-###: {Feature Title}
- {etc.}

Plan Phases (high-level) — each phase MUST include hours (L/S/H), costs (L/S/H), decision point.
Phase X — {Phase Name} (D-XXX)
  - T-### {Task Title} ({low}/{standard}/{high} hrs) — costs per rate band
  - T-### {Task Title} ({low}/{standard}/{high} hrs)
  - Totals L/S/H: compute sum of tasks (agent to fill costs)

Project totals (Agents MUST compute & populate)
- Hours L/S/H: sum of phases
- Cost L/S/H: sum of phases

Decision Points
- D-001 {Decision Point Title}
- D-002 {Decision Point Title}
- {etc.}
