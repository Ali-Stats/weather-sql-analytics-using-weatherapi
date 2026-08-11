SELECT
    city_id,
    COUNT(*) AS observations,
    ROUND(AVG(temperature)::numeric, 2) AS avg_temperature,
    MIN(temperature) AS min_temperature,
    MAX(temperature) AS max_temperature,
    ROUND(AVG(wind_speed)::numeric, 2) AS avg_wind_speed
FROM weather_history
GROUP BY city_id
ORDER BY avg_temperature DESC;
