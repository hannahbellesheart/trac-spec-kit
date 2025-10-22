# estimate-provider.md (design & algorithm)

Purpose
- Define the algorithm, data flow and caching rules for deriving citation-backed per-task estimates.

High-level flow
1. Task categorization: map a task to N search categories (keywords + canonical task type).
2. Source collection: query allowed reference sites for matching items (prefer structured APIs).
3. Extraction: extract hourly rates or project quotes and relevant time estimates and raw text excerpts.
4. Normalization:
   - Convert salaries/project quotes to hourly rates where necessary (explicitly document assumptions).
   - Collect array of hourly rates and time estimates.
5. Aggregation:
   - Hours: compute low/standard/high from collected time estimations (25th, 50th, 90th percentiles).
   - Rates: compute low/standard/high from collected hourly rates (25th, 50th, 90th).
6. Cost calculation: cost = hours * rates per band.
7. Confidence:
   - Confidence = f(N_sources, variance, match_quality)
   - N_sources >= 3 required.
   - If Confidence < 0.6 -> mark PROVISIONAL and create Decision Point.
8. Output:
   - Annotated task entry with hours, rates, costs, confidence, sources[] (url,title,excerpt).
   - JSONL log entry ACTION=ESTIMATE-CALC.

Legal & ToS step
- For each source URL, agent must record a ToS-check entry (either API allowed or HTML scrape allowed). If disallowed, skip and document.

Caching & TTL
- Cache fetched pages under `.trac/cache/<project>/<hash>.json` with fetch_ts, source_url, and raw excerpt.
- TTL default = `cache_ttl_days` in .tproj (30 days). Expire older entries.

Mapping examples (task -> keywords)
- "OpenAPI authoring" -> ["OpenAPI spec authoring","API design","OpenAPI documentation services"]
- "Mock server setup" -> ["API mock server setup","Stoplight Prism setup","API mocking services"]
- "CI job authoring" -> ["GitHub Actions CI setup","CI pipeline authoring","Spectral lint setup"]

Quality controls
- Keep raw snapshots of source pages for auditing.
- Flag and surface outliers; compute median and robust stats.

Implementation note
- Implement as a pluggable module (node/python). Provide a small adapter for each allowed source (API adapter or HTML extractor). Prefer API adapters first.
