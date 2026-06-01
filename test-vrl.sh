#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

VECTOR_PORT="${VECTOR_PORT:-1234}"
VECTOR_USERNAME="${VECTOR_USERNAME:-admin}"
VECTOR_PASSWORD="${VECTOR_PASSWORD:-admin}"
VECTOR_DB_URL="${VECTOR_DB_URL:-postgres://postgres@localhost:5432/postgres}"

# Run Vector unit tests for transforms.vrl using the same image as docker-compose.
docker run --rm \
  -e VECTOR_PORT="$VECTOR_PORT" \
  -e VECTOR_USERNAME="$VECTOR_USERNAME" \
  -e VECTOR_PASSWORD="$VECTOR_PASSWORD" \
  -e VECTOR_DB_URL="$VECTOR_DB_URL" \
  -v "$ROOT_DIR/vector.toml:/app/vector.toml:ro" \
  -v "$ROOT_DIR/transforms.vrl:/app/transforms.vrl:ro" \
  -v "$ROOT_DIR/tests/vector-tests.yaml:/app/vector-tests.yaml:ro" \
  timberio/vector:0.53.0-debian \
  test /app/vector.toml /app/vector-tests.yaml
