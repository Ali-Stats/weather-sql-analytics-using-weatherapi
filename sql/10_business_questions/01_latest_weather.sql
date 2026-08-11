-- Latest weather observation for every city.
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
    c.state,
    r.observed_at,
    r.temperature,
    r.wind_speed
FROM ranked r
JOIN city_dimension c ON c.city_id = r.city_id
WHERE r.rn = 1
ORDER BY c.city;
