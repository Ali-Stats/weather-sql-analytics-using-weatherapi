SELECT
    c.city,
    w.observed_at,
    w.temperature,
    LAG(w.temperature) OVER (
        PARTITION BY w.city_id
        ORDER BY w.observed_at
    ) AS previous_temperature,
    LEAD(w.temperature) OVER (
        PARTITION BY w.city_id
        ORDER BY w.observed_at
    ) AS next_temperature
FROM weather_history AS w
JOIN city_dimension AS c
    ON c.city_id = w.city_id
ORDER BY c.city, w.observed_at;
