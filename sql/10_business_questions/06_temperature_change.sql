WITH changes AS (
    SELECT
        city_id,
        observed_at,
        temperature,
        LAG(temperature) OVER (
            PARTITION BY city_id
            ORDER BY observed_at
        ) AS previous_temperature
    FROM weather_history
)
SELECT
    c.city,
    x.observed_at,
    x.temperature,
    x.previous_temperature,
    x.temperature - x.previous_temperature AS temperature_change
FROM changes x
JOIN city_dimension c ON c.city_id = x.city_id
WHERE x.previous_temperature IS NOT NULL
ORDER BY c.city, x.observed_at;
