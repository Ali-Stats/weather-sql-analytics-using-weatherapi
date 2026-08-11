-- Portable approach using ROW_NUMBER()
WITH ranked AS (
    SELECT
        city_id,
        observed_at,
        temperature,
        wind_speed,
        ROW_NUMBER() OVER (
            PARTITION BY city_id
            ORDER BY observed_at DESC
        ) AS rn
    FROM weather_history
)
SELECT
    c.city,
    r.observed_at,
    r.temperature,
    r.wind_speed
FROM ranked AS r
JOIN city_dimension AS c
    ON c.city_id = r.city_id
WHERE r.rn = 1
ORDER BY c.city;

-- PostgreSQL-specific shortcut
SELECT DISTINCT ON (w.city_id)
    c.city,
    w.observed_at,
    w.temperature,
    w.wind_speed
FROM weather_history AS w
JOIN city_dimension AS c
    ON c.city_id = w.city_id
ORDER BY w.city_id, w.observed_at DESC;
