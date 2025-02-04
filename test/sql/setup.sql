CREATE EXTENSION zombodb;
--CREATE SCHEMA postgis; CREATE EXTENSION postgis SCHEMA postgis;
ALTER DATABASE contrib_regression SET search_path = public, dsl;
ALTER DATABASE contrib_regression SET max_parallel_workers_per_gather TO 0;
--SELECT zdb.enable_postgis_support();
CREATE OR REPLACE FUNCTION assert(actual int8, expected int8, message text) RETURNS bool LANGUAGE plpgsql AS $$
BEGIN
    IF expected IS DISTINCT FROM actual THEN
        RAISE EXCEPTION 'ASSERT: %: expected=%, actual=%', message, expected, actual;
    END IF;

    RETURN true;
END;
$$;
CREATE OR REPLACE FUNCTION assert(actual ANYELEMENT, expected anyelement, message text) RETURNS bool LANGUAGE plpgsql AS $$
BEGIN
    IF expected IS DISTINCT FROM actual THEN
        RAISE EXCEPTION 'ASSERT: %: expected=%, actual=%', message, expected, actual;
    END IF;

    RETURN true;
END;
$$;