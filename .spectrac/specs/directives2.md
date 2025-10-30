# Directives: SpecTRAC Core Rules and Configuration

This document defines:
- **common rules**
- **configurable tokens**
- **options**
- **defaults for options and selections** used by SpecTRAC for generating project documentation and code.

---

## 1. File Definitions and Creation

All core documentation files (specs) are generated within a dedicated project's artifact directory.

| File Name | Purpose | Output Location (Solution Context) |
| :--- | :--- | :--- |
| `spectrac-alpha.stp` | Project Configuration/State (JSON) | `./services/{project}/.spectrac/` |
| `directives.md` | Core rules, options, and defaults (This document) | `./services/{project}/.spectrac/` |
| `overview.md` | High-level architecture and component interactions (formerly design.md) | `./services/{project}/.spectrac/specs/` |
| `requirements.md` | User stories & acceptance criteria (EARS notation) | `./services/{project}/.spectrac/specs/` |
| `scope.md` | Features, phases, tasks, and decision points | `./services/{project}/.spectrac/specs/` |
| `tasks.md` | Phased, trackable implementation plan with estimates | `./services/{project}/.spectrac/specs/` |
| `structure.md` | File organization and naming conventions | Derived from Project Context (`spectrac.tsln`) |

---

## 2. Configuration Tokens and Defaults

These tokens are used internally and can be overridden via the `{$projectname}.stp` JSON file.

| Token | Description | Selectable Options/Choices | Default Value |
| :--- | :--- | :--- | :--- |
| `$projectname` | Name used for the project root and state file. | Must be alphanumeric and hyphenated | `spectrac-alpha` (from P-001) |
| `$isFullyAutomated` | If true, uses all defaults without prompts (e.g., auto-commit). | `true`, `false` | `false` |
| `$path` | Target project source for analysis. | Any valid file path. | `./services/spec-agent` |
| `$requirements_format`| Notation used for capturing requirements. | `EARS`, `Gherkin`, `Freeform` | **`EARS`** |
| `$task_estimate_level`| Level of time/cost estimation provided. | `low`, `standard`, `high`, `all` | **`all`** (L/S/H bands) |
| `$target_languages` | Default languages for client SDK generation. | `TypeScript`, `Python`, `Go`, etc. | `TypeScript`, `Python` |

---

## 3. Allowed Tools and Endpoints

### Allowed Sites for Task Estimation

Estimates in `scope.md` and `tasks.md` **MUST** be based on data from or methodologies derived from the following trusted sources. If data is not available from these sources, the estimates must be clearly identified as internal and justified. The combined list from global (`spectrac.tsln`) and project (`spectrac-alpha.stp`) manifests is authoritative.

* `https://www.upwork.com/pricing-tool/`
* `https://www.toptal.com/rate-estimator`
* `https://www.ziprecruiter.com/`
* `https://www.velvetjobs.com/`
* `https://arc.dev/`
* *(See `spectrac-alpha.stp` for the complete list of allowed rate sources.)*

### Allowed Tools for Analysis and Generation

* File Content Fetcher (`File Fetcher`)
* Google Search (`google:search`) - Used for research and external price estimates.
* Spectral (for linting)
* Prism (for mock server)
* OpenAPI Generator (for client/server generation)
* Pact (for contract testing)

### Blocked URLs/Endpoints

* (None by default. Can be configured in `spectrac-alpha.stp`)

---

## 4. Core Standards & Governance (Merged Rules)

### 4.1. Solution & Project Governance (`commands.md` summary)

| Rule Category | Directive |
| :--- | :--- |
| **Context Check** | On start, agent **MUST** check for `spectrac.tsln`. If present, treat the repository as a **Solution**. |
| **Project Target** | If the user prompt is ambiguous in a Solution Context, the agent **MUST** prompt the user to select a target project (`P-001`, `P-002`, or `All projects`). |
| **Global ID Format**| Global IDs **MUST** include the project ID prefix: **`{project_id}-F-###`**, **`{project_id}-T-###`**, **`{project_id}-D-###`**. |
| **Decision Points**| If a change affects >1 project or a shared API, agent **MUST** create a solution-level Decision Point (**`D-SOL-###`**). |
| **Artifact Location**| Per-project artifacts go to: **`{project}/.spectrac/specs/`**. Solution-level artifacts go to: **`.spectrac/solution/`**. |
| **Logging** | Per-project logs: **`{project}/.spectrac/logs/`**. Solution logs: **`.spectrac/logs/`**. Logs **MUST** include `project_id` and `solution_id`. |
| **Concurrency** | Agents **MUST NOT** concurrently write to the same log file from multiple projects. |

### 4.2. API Standards (`api-standards.md` & `security-policies.md` summary)

| Standard | Directive |
| :--- | :--- |
| **Spec Format** | **OpenAPI 3.1 (YAML)** for REST endpoints. |
| **Naming** | Endpoint naming: **`/resource`** (plural) for collections; **`/resource/{id}`** for single items. |
| **Versioning** | **Semantic versioning** for public APIs. Internal APIs may use date-based versioning. |
| **Error Handling** | Use standard HTTP status codes. Include an **`error`** schema for error bodies. |
| **Authentication** | Use **OAuth2 / OIDC** for external APIs (recommended); **API keys** for internal use only. |
| **Input Security** | **Validate and sanitize all inputs** (schema-driven). |
| **Logging Security** | Log trace/request IDs only — **DO NOT log PII**. Do not include secrets in specs or logs. |
| **Linting** | CI builds and runs **Spectral** lint and spec validation on PRs. API info **MUST** include `info.contact`. |

### 4.3. Code Conventions (`code-conventions.md` summary)

| Convention | Directive |
| :--- | :--- |
| **File Naming** | Use **kebab-case** for file names (e.g., `feature-file.py`). |
| **Variable Naming** | Use **camelCase** for variables (e.g., `requestBody`). |
| **Type/Class Naming**| Use **PascalCase** for types/classes (e.g., `UserModel`). |
| **Organization** | Organize code under **`src/{service}/`** with index exports. |
| **Functionality** | Prefer **small, testable functions** and **dependency injection** for services interacting with external systems. |

### 4.4. Testing Standards (`testing-standards.md` summary)

| Test Type | Directive |
| :--- | :--- |
| **Unit Tests** | Focus on **pure functions** and **model validation**. |
| **Integration Tests**| Run against **mock server or staging environment**. |
| **Contract Tests** | Use **Pact** or generated provider tests for critical consumers. |
| **Coverage** | Aim for actionable coverage; use coverage gates in CI only for critical modules. (P-001 has a 90% target for core logic). |

### 4.5. Deployment Workflow (`deployment-workflow.md` summary)

| Workflow Step | Directive |
| :--- | :--- |
| **PR Validation** | CI builds and runs **Spectral lint and spec validation** on PRs. |
| **Release Trigger** | Merge to **main** triggers release workflow (manual approval step for public/external APIs). |
| **Artifact Publish**| Automate **doc/client publish** on release tags. |
| **Rollback** | Create a point-release revert and follow documented migration guides. |
