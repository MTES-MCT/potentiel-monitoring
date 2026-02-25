CREATE OR REPLACE PROCEDURE generic_retention (config jsonb) LANGUAGE PLPGSQL AS $$
DECLARE drop_after interval;
schema varchar;
name varchar;
BEGIN
SELECT jsonb_object_field_text (config, 'drop_after')::interval INTO STRICT drop_after;
IF drop_after IS NULL THEN RAISE EXCEPTION 'Config must have drop_after';
END IF;
-- You can modify the following query to add a more precise retention policy.
FOR schema,
name IN
SELECT hypertable_schema,
    hypertable_name
FROM timescaledb_information.hypertables LOOP RAISE NOTICE '%',
    format('%I.%I', schema, name);
PERFORM drop_chunks(
    format('%I.%I', schema, name),
    older_than => drop_after
);
COMMIT;
END LOOP;
END $$;