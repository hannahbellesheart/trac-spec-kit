# Directives: SpecTRAC Core Rules and Configuration

This document defines:
- common rules
- configurable tokens
- options
- defaults for options and selections used by SpecTRAC for generating project documentation and code.

## 1. File Definitions and Creation

All core documentation files are generated within a dedicated project directory (default: `./spectrac/`).

| File Name | Purpose | Output Location |
| :--- | :--- | :--- |
| `{$projectname}.stp` | Project Configuration/State (JSON) | `./spectrac/` |
| `directives.md` | Core rules, options, and defaults (This document) | `./spectrac/` |
| `overview.md` | Detailed project summary from source analysis | `./spectrac/` |
| `requirements.md` | User stories & acceptance criteria (EARS notation) | `./spectrac/` |
| `design.md` | Technical architecture, diagrams, and scope estimates | `./spectrac/` |
| `tasks.md` | Phased, trackable implementation plan with estimates | `./spectrac/` |
| `/structure` | File organization and naming conventions (Conceptual) | Derived from Project Context |

## 2. Configuration Tokens and Defaults

These tokens are used internally and can be overridden via the `{$projectname}.stp` JSON file.

| Token | Description | Selectable Options/Choices | Default Value |
| :--- | :--- | :--- | :--- |
| `$projectname` | Name used for the project root and state file. | Must be alphanumeric and hyphenated | Last leaf of `-path` or current directory. |
| `$isFullyAutomated` | If true, uses all defaults without prompts. | `true`, `false` | `false` |
| `$path` | Target source for analysis (repo, file, doc, prompt). | Any valid file path, URL, or descriptive string. | Current directory (`./`) |
| `$requirements_format`| Notation used for capturing requirements. | `EARS`, `Gherkin`, `Freeform` | `EARS` |
| `$task_estimate_level`| Level of time/cost estimation provided. | `low`, `standard`, `high`, `all` | `all` |

## 3. Allowed Tools and Endpoints

### Allowed Sites for Task Estimation

Estimates in `design.md` and `tasks.md` **MUST** be based on data from or methodologies derived from the following trusted sources. If data is not available from these sources, the estimates must be clearly identified as internal and justified.

* `https://www.upwork.com/pricing-tool/`
* `https://www.toptal.com/rate-estimator`
* *(Additional allowed sites must be manually added to `spectrac.stp`)*

### Allowed Tools for Analysis and Generation

* File Content Fetcher (`File Fetcher`)
* Google Search (`google:search`) - Used for research and external price estimates.

### Blocked URLs/Endpoints

* (None by default. Can be configured in `spectrac.stp`)
