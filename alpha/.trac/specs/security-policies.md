# security-policies.md

- Validate and sanitize all inputs (schema-driven).
- Do not include secrets in specs or logs.
- Use OAuth2 / OIDC for external APIs (recommended); API keys for internal use only.
- Log trace/request IDs only — do not log PII.
