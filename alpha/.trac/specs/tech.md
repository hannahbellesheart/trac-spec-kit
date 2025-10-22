# tech.md

Purpose: agent-facing recommendations for tools and generator choices.

Primary recommendations (initial, agent-choice defaults)
- Spec format: OpenAPI 3.1 (YAML) for REST endpoints (primary).
- Payload schemas: JSON Schema (embedded or referenced).
- Linting: Spectral with a tuned rule set (strict by default).
- Mock server: Prism (Stoplight) for local developer mocking.
- Client/server generation: OpenAPI Generator (openapi-generator-cli).
- Contract testing: Pact (consumer-driven) or generated provider tests for critical endpoints.
- CI: GitHub Actions recommended; jobs include spectral-lint, spec-validation, generate-tests, contract-verification, optional publish-docs.
- Languages for sample SDKs: default: TypeScript and Python (confirmable in .tproj).

Agent integration points
- openapi-generator-cli generate -i .trac/specs/openapi.yaml -g <lang> -o client/<lang>
- prism mock .trac/specs/openapi.yaml
- npx @stoplight/spectral lint .trac/specs/openapi.yaml

Constraints
- Avoid committing generated runtime artifacts by default. Agents must read .tproj for override.
- Network operations (e.g., fetching remote schemas, fetching rates) require explicit permission in .tproj or Decision Point.
