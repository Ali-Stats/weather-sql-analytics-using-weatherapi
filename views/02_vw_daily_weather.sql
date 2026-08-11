CREATE OR REPLACE VIEW vw_daily_weather AS
SELECT
    c.city_id,
    c.city,
    c.state,
    c.region,
    DATE(w.observed_at) AS observation_date,
    ROUND(AVG(w.temperature)::numeric, 2) AS avg_temperature,
    MIN(w.temperature) AS min_temperature,
    MAX(w.temperature) AS max_temperature,
    ROUND(AVG(w.wind_speed)::numeric, 2) AS avg_wind_speed,
    COUNT(*) AS observations
FROM city_dimension c
JOIN weather_history w
    ON c.city_id = w.city_id
GROUP BY
    c.city_id, c.city, c.state, c.region, DATE(w.observed_at);
