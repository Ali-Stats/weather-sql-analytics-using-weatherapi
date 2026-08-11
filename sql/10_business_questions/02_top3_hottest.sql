WITH ranked AS (
    SELECT
        city_id,
        observed_at,
        temperature,
        RANK() OVER (
            PARTITION BY city_id
            ORDER BY temperature DESC
        ) AS temperature_rank
    FROM weather_history
)
SELECT
    c.city,
    r.observed_at,
    r.temperature,
    r.temperature_rank
FROM ranked r
JOIN city_dimension c ON c.city_id = r.city_id
WHERE r.temperature_rank <= 3
ORDER BY c.city, r.temperature_rank;
