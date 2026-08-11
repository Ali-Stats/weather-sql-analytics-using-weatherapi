SELECT
    city_id,
    COUNT(*) AS observations,
    ROUND(AVG(temperature)::numeric, 2) AS avg_temperature
FROM weather_history
GROUP BY city_id
HAVING COUNT(*) >= 20
ORDER BY observations DESC;
