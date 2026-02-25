CREATE TABLE logs (
  ts TIMESTAMPTZ NOT NULL,
  message TEXT,
  container VARCHAR(100),
  level VARCHAR(20),
  service VARCHAR(100),
  meta JSONB,
  inserted_at TIMESTAMPTZ NOT NULL
);