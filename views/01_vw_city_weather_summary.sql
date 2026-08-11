CREATE OR REPLACE VIEW vw_city_weather_summary AS
SELECT
    c.city_id,
    c.city,
    c.state,
    c.region,
    COUNT(w.observation_id) AS total_observations,
    ROUND(AVG(w.temperature)::numeric, 2) AS avg_temperature,
    MIN(w.temperature) AS min_temperature,
    MAX(w.temperature) AS max_temperature,
    ROUND(AVG(w.wind_speed)::numeric, 2) AS avg_wind_speed,
    COUNT(*) FILTER (WHERE w.temperature > 30) AS hot_observations,
    COUNT(*) FILTER (WHERE w.temperature < 20) AS cold_observations
FROM city_dimension c
LEFT JOIN weather_history w
    ON c.city_id = w.city_id
GROUP BY c.city_id, c.city, c.state, c.region;
