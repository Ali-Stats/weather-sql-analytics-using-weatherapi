SELECT
    c.city,
    w.observed_at,
    w.temperature,
    ROW_NUMBER() OVER (
        PARTITION BY w.city_id
        ORDER BY w.temperature DESC
    ) AS row_number,
    RANK() OVER (
        PARTITION BY w.city_id
        ORDER BY w.temperature DESC
    ) AS rank,
    DENSE_RANK() OVER (
        PARTITION BY w.city_id
        ORDER BY w.temperature DESC
    ) AS dense_rank,
    NTILE(4) OVER (
        PARTITION BY w.city_id
        ORDER BY w.temperature
    ) AS temperature_quartile
FROM weather_history AS w
JOIN city_dimension AS c
    ON c.city_id = w.city_id
ORDER BY c.city, w.temperature DESC;
