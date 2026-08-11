SELECT
    c.city,
    ROUND(AVG(w.temperature)::numeric, 2) AS avg_temperature,
    ROUND(AVG(w.wind_speed)::numeric, 2) AS avg_wind_speed,
    COUNT(*) AS observations
FROM weather_history w
JOIN city_dimension c ON c.city_id = w.city_id
GROUP BY c.city
ORDER BY avg_temperature DESC;
