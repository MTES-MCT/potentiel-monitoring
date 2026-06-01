# AGENTS

## Project Context
- Repository: potentiel-monitoring
- Purpose: collect, transform, and store Potentiel application logs.
- Stack:
  - PostgreSQL + TimescaleDB for storage
  - Vector for ingestion and VRL transforms
  - Log source: Scalingo log drain

## Key Files
- `transforms.vrl`: main log parsing and enrichment logic
- `tests/vector-tests.yaml`: Vector unit tests for VRL behavior
- `vector.toml`: Vector pipeline configuration
- `scripts/*.sql`: schema, indexes, hypertable, retention

## Runbook
- Run VRL tests:
  - `./test-vrl.sh`
- Validate Vector config (if needed):
  - `docker compose run --rm vector validate /app/vector.toml`

## Agent Instructions
- Prefer code changes over test changes unless explicitly requested.
- Keep edits minimal and focused; avoid unrelated refactors.
- After transform changes, run `./test-vrl.sh` and report failing assertions precisely.
- When tests fail, fix root cause in `transforms.vrl` first.
- Preserve existing log contract unless change is requested:
  - parsed `message`
  - `level` classification
  - HTTP metadata extraction in `.meta`
  - timestamp in `.ts`
- Do not introduce behavior that silently drops fields used by tests.

## Logging Semantics (Current Expectations)
- Structured app logs: parse header timestamp/container and message payload.
- Logs with explicit level (debug/info/error/warn): keep parsed level.
- HTTP logs without explicit level: set `level = "http"` and populate `.meta`.
- JS stack-trace/error lines: classify as `level = "error"`.

## Output Style
- Be concise in summaries.
- Include exact file paths changed and why.
- If unable to run tests, state it clearly.