CREATE EXTENSION IF NOT EXISTS timescaledb;

SELECT create_hypertable('logs', by_range('ts'));
