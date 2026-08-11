SELECT
    c.city,
    w.observed_at,
    w.temperature,
    ROUND(
        AVG(w.temperature) OVER (
            PARTITION BY w.city_id
            ORDER BY w.observed_at
        )::numeric, 2
    ) AS running_avg,
    ROUND(
        AVG(w.temperature) OVER (
            PARTITION BY w.city_id
            ORDER BY w.observed_at
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        )::numeric, 2
    ) AS moving_avg_3,
    SUM(w.wind_speed) OVER (
        PARTITION BY w.city_id
        ORDER BY w.observed_at
    ) AS running_wind_speed
FROM weather_history AS w
JOIN city_dimension AS c
    ON c.city_id = w.city_id
ORDER BY c.city, w.observed_at;
