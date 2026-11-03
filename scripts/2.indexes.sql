CREATE INDEX IF NOT EXISTS logs_level_distinct_idx ON logs (level) WITH (timescaledb.transaction_per_chunk)
WHERE level IS NOT NULL;
CREATE INDEX IF NOT EXISTS logs_service_distinct_idx ON logs (service) WITH (timescaledb.transaction_per_chunk)
WHERE service IS NOT NULL;
CREATE INDEX IF NOT EXISTS logs_container_distinct_idx ON logs (container) WITH (timescaledb.transaction_per_chunk)
WHERE container IS NOT NULL;