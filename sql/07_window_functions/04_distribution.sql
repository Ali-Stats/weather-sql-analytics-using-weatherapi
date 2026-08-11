SELECT
    c.city,
    w.temperature,
    ROUND(
        PERCENT_RANK() OVER (
            PARTITION BY w.city_id
            ORDER BY w.temperature
        )::numeric, 2
    ) AS percent_rank,
    ROUND(
        CUME_DIST() OVER (
            PARTITION BY w.city_id
            ORDER BY w.temperature
        )::numeric, 2
    ) AS cume_dist
FROM weather_history AS w
JOIN city_dimension AS c
    ON c.city_id = w.city_id
ORDER BY c.city, w.temperature;
