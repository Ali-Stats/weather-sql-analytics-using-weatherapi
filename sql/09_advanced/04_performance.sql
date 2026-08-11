EXPLAIN
SELECT *
FROM weather_history
WHERE city_id = 1;

EXPLAIN ANALYZE
SELECT *
FROM weather_history
WHERE city_id = 1;

-- Example indexes are created separately in database/04_indexes.sql.
