# deployment-workflow.md

- CI builds and runs spectral lint and spec validation on PRs.
- Merge to main triggers release workflow (manual approval step for public/external APIs).
- Automate doc/client publish on release tags.
- Rollback: create a point-release revert and follow documented migration guides.
