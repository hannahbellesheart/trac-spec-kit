# Directives: SpecTRAC Core Rules and Configuration

This document serves as the authoritative guide, defining common rules, configuration tokens, options, required standards, and artifact generation rules for the SpecTRAC workflow.

---

## 1. Artifact Definitions and Creation

All core specification files (specs) are generated within a dedicated project's artifact directory, adhering to the structure defined in **Section 4.1**.

| File Name | Purpose | Output Location (Solution Context) |
| :--- | :--- | :--- |
| **`{$projectname}.stp`** | Project Configuration/State (JSON) | **`./services/{project}/.spectrac/`** |
| `spectrac.tsln` | Solution Manifest (Multi-project coordination) | **Repository Root** |
| `directives.md` | Core rules, options, and defaults (This document) | `./services/{project}/.spectrac/` |
| `design.md` | High-level architecture, component interactions, and sequence diagrams. | **`./services/{project}/.spectrac/specs/`** |
| `requirements.md` | EARS-style functional and non-functional requirements. | `./services/{project}/.spectrac/specs/` |
| `scope.md` | Features, phases, tasks, estimates, and decision points. | `./services/{project}/.spectrac/specs/` |
| `tasks.md` | Phased, trackable implementation plan with cost/time estimates. | `./services/{project}/.spectrac/specs/` |
| `logs/` | Structured, append-only JSONL log entries. | **`./{project}/.spectrac/logs/`** |

---

## 2. Configuration Tokens and Defaults (Workspace Variables)

These tokens are used internally and are configured via the project's state file (`.stp`).

| Token | Description | Selectable Options/Choices | Default Value (P-001) |
| :--- | :--- | :--- | :--- |
| **`$projectname`** | Name used for the project root and state file. | Alphanumeric and hyphenated | `spectrac-alpha` |
| **`$isFullyAutomated`**| If true, uses all defaults without prompts (e.g., auto-commit PRs). | `true`, `false` | `false` |
| **`$path`** | Target project source for analysis. | Valid file path, URL, or descriptive string. | `./services/spec-agent` |
| **`$requirements_format`**| Notation used for capturing requirements. | `EARS`, `Gherkin`, `Freeform` | **`EARS`** |
| **`$task_estimate_level`**| Level of time/cost estimation provided. | `low`, `standard`, `high`, `all` | **`all`** (L/S/H bands) |
| **`$target_languages`**| Default languages for client SDK generation. | `TypeScript`, `Python`, `Go`, etc. | `TypeScript`, `Python` |
| **`$rate_confidence_min`**| Minimum confidence score required to finalize an estimate. | `0.0` to `1.0` | `0.6` |
| **`$commit_policy`** | Determines if artifacts are auto-committed. | `true`, `false` (from `commit_generated_artifacts`) | `true` |
| **`$sync_github_issues`**| If true, tasks/DPs generate GitHub Issues. | `true`, `false` (from `sync_with_github_issues`) | `true` |
| **`$task_runner`** | The intended environment for running Spectrac tasks. | `PowerShell`, `Python CLI`, `Web UI` | `PowerShell / Python CLI` |

---

## 3. Artifact Generation Rules

### 3.1. Requirements (`requirements.md` Rules)

* **Format:** All functional behaviors **MUST** be expressed in **EARS notation** (WHEN/THE SYSTEM SHALL).
* **Traceability:** For every requirement, include: **Feature ID** (F-###), **Priority** (P0/P1/P2), **Acceptance Criteria** (as bullets), and **Trace to tasks** (T-###) when tasks are generated.
* **Non-Functional:** Non-functional requirements (Auditability, Safety) **MUST** also be written in EARS.

### 3.2. Design (`design.md` Rules)

* **Content:** Must include High-level architecture, component interactions, and sequence diagrams (Mermaid format).
* **Persistence:** Specs are written to `.spectrac/specs`. Logs are append-only structured text in `.spectrac/logs`.

### 3.3. Tasks and Scope (`tasks.md`, `scope.md` Rules)

* **Task Structure:** Tasks **MUST** be produced with unique Task IDs (T-XXX), estimate bands (L/S/H), and explicit dependencies.
* **Estimates:** Project totals for Hours and Costs in all bands **MUST** be computed and populated in `scope.md` before submission for Decision Point approval.
* **Placeholder:** Agent **MUST** mark all placeholder costs as `PROVISIONAL` if no citation-backed estimate is available.
* **Status Update:** All status changes (`todo`, `in-progress`, `done`, `blocked`) **MUST** trigger a `TASK-UPDATE` log entry in the logs.

### 3.4. Idempotency & Revision Control

* Agents **MUST** detect if the same prompt has been processed. If re-run, produce a new revision (increment version) or create a **Decision Point** for manual merge.
* Edits to existing requirements **MUST** include a diff paragraph in the session log indicating the previous value and changed lines.

---

## 4. Governance and Technical Standards

### 4.1. Solution & ID Scoping (`structure.md`, `commands.md`)

| Rule Category | Directive |
| :--- | :--- |
| **Context Check** | On start, agent **MUST** check for `spectrac.tsln`. If present, the repository is a **Solution Context**. |
| **Repository Layout** | **Solution Context:** `spectrac.tsln` at root. Per-project artifacts live in the per-project **`.spectrac/`** directory. |
| **Project Targeting** | If prompt is ambiguous, agent **MUST** prompt user to select one of: Single Project, "All projects", or "Create new project". |
| **Global ID Format**| Global IDs **MUST** include the project ID prefix: **`{project_id}-F-###`**, **`{project_id}-T-###`**, **`{project_id}-D-###`**. |
| **Solution-Level ID** | Cross-project changes or shared API changes **MUST** create a solution-level Decision Point (**`D-SOL-###`**). |
| **Task Mapping** | Tasks created for a project **MUST** map to GitHub Issues using the project label (project-id). |

### 4.2. Logging and Audit (`LOG SCHEMA`, `security-policies.md`)

* **Log Format:** JSONL structured logs, adhering strictly to the `TRAC Log Entry` schema.
* **Log Fields:** Required fields: `ts` (ISO8601 UTC), `action`, `agent`, `project_id`, `entries`.
* **Auditability:** Every artifact generation or modification **MUST** append a structured log entry (`ACTION=CREATE/UPDATE`) and include user, timestamp, action, and affected IDs.
* **Safety:** **DO NOT log PII or secrets.** Redact all suspect content with **`<REDACTED>`**.

### 4.3. Estimation Algorithm (`estimate-provider.md`)

1.  **Task Categorization:** Map a task to N search categories (keywords + canonical task type).
2.  **Source Collection:** Query allowed reference sites/APIs (`allowed_rate_sources`).
3.  **Normalization:** Convert salaries/quotes to hourly rates (explicitly documenting assumptions).
4.  **Aggregation:** Compute L/S/H hours and Rates (25th, 50th, 90th percentiles).
5.  **Confidence Check:** Confidence = f(N\_sources, variance, match\_quality). If Confidence **< 0.6**, mark **PROVISIONAL** and create a Decision Point. **N\_sources >= 3 required.**
6.  **Caching:** Cache fetched pages under **`.spectrac/cache/<project>/<hash>.json`** with `fetch_ts`. TTL is set by `cache_ttl_days`.
7.  **Legal Check:** For each source, agent **MUST** record a ToS-check entry.

### 4.4. API, Coding, and Testing Standards (`tech.md`, `api-standards.md`, `code-conventions.md`, `testing-standards.md`)

| Standard | Directive |
| :--- | :--- |
| **Spec Format** | **OpenAPI 3.1 (YAML)** for REST endpoints (Primary). |
| **Linting** | **Spectral** with tuned rule set (strict by default). |
| **Mock Server** | **Prism** (Stoplight) for local developer mocking. |
| **Client Gen** | **OpenAPI Generator** (`openapi-generator-cli`). |
| **Contract Testing** | **Pact** (consumer-driven) or generated provider tests for critical endpoints. |
| **Input Security** | **Validate and sanitize all inputs** (schema-driven). |
| **Code Naming** | **kebab-case** for file names; **camelCase** for variables; **PascalCase** for types/classes. |
| **Testing Goal** | Prioritize small, testable functions; **P-001 target: 90% functional coverage** for core logic. |

---

## 5. Recreated Individual Template Files

These templates are the starting point for artifact generation and must be filled by the agent following the rules in `directives.md`.

### `requirements.md` (Template)

```markdown
# requirements.md (EARS-style)

Source: user directive ({current-date}) — Principal EA: hannahbellesheart
Format: EACH requirement MUST be one EARS statement with acceptance criteria and traceable Feature ID.

INSTRUCTIONS FOR AGENTS (See directives.md Section 3.1 for full rules):
- For every natural-language prompt, extract functional and non-functional requirements and write them in EARS.
- For each requirement, include: Feature ID (F-###), Priority (P0/P1/P2), Acceptance criteria (as bullets), Trace to tasks (T-###).

EXAMPLE REQUIREMENTS (Agent MUST replace with actual content):

F-001 — {Short Feature Description} (P0)
WHEN {triggering condition},
THE SYSTEM SHALL {required system response}.
Acceptance criteria:
  - GIVEN {precondition}, WHEN {trigger}, THEN {testable outcome}.
  - {further criteria}

F-NF-001 — Auditability (P0)
WHEN any artifact is generated or modified,
THE SYSTEM SHALL append a structured log entry to .spectrac/logs and include user, timestamp, action, and affected IDs.
