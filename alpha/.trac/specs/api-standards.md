```text
# api-standards.md

- Use OpenAPI 3.1 for REST endpoints (YAML).
- Endpoint naming: /resource (plural) for collections; /resource/{id} for single items.
- Use standard HTTP status codes. Include an "error" schema for error bodies.
- Use semantic versioning for public APIs; internal APIs may use date-based versioning if necessary.
- Include examples for requests and responses where possible.
```
