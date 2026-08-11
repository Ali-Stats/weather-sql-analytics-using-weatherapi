CREATE OR REPLACE VIEW vw_city_weather_alert_summary AS
WITH weather_stats AS (
    SELECT
        city_id,
        COUNT(*) AS total_observations,
        ROUND(AVG(temperature)::numeric, 2) AS avg_temperature,
        MIN(temperature) AS min_temperature,
        MAX(temperature) AS max_temperature,
        ROUND(AVG(wind_speed)::numeric, 2) AS avg_wind_speed,
        COUNT(*) FILTER (WHERE temperature > 30) AS hot_observations,
        COUNT(*) FILTER (WHERE temperature < 20) AS cold_observations
    FROM weather_history
    GROUP BY city_id
),
alert_stats AS (
    SELECT
        city_id,
        COUNT(*) AS total_alerts
    FROM city_alerts
    GROUP BY city_id
)
SELECT
    c.city_id,
    c.city,
    c.state,
    c.region,
    COALESCE(w.total_observations, 0) AS total_observations,
    w.avg_temperature,
    w.min_temperature,
    w.max_temperature,
    w.avg_wind_speed,
    COALESCE(w.hot_observations, 0) AS hot_observations,
    COALESCE(w.cold_observations, 0) AS cold_observations,
    COALESCE(a.total_alerts, 0) AS total_alerts
FROM city_dimension c
LEFT JOIN weather_stats w
    ON c.city_id = w.city_id
LEFT JOIN alert_stats a
    ON c.city_id = a.city_id;
