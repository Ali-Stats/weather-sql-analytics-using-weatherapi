CREATE OR REPLACE VIEW vw_temperature_trends AS
WITH base AS (
    SELECT
        w.city_id,
        w.observed_at,
        w.temperature,
        w.wind_speed,
        LAG(w.temperature) OVER (
            PARTITION BY w.city_id
            ORDER BY w.observed_at
        ) AS previous_temperature
    FROM weather_history w
)
SELECT
    c.city_id,
    c.city,
    c.state,
    c.region,
    b.observed_at,
    b.temperature,
    b.wind_speed,
    b.previous_temperature,
    b.temperature - b.previous_temperature AS temperature_change,
    ROUND(
        AVG(b.temperature) OVER (
            PARTITION BY b.city_id
            ORDER BY b.observed_at
        )::numeric, 2
    ) AS running_avg_temperature,
    ROUND(
        AVG(b.temperature) OVER (
            PARTITION BY b.city_id
            ORDER BY b.observed_at
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        )::numeric, 2
    ) AS moving_avg_3
FROM base b
JOIN city_dimension c
    ON c.city_id = b.city_id;
