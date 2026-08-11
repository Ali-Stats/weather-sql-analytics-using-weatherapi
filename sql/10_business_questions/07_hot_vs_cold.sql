SELECT
    c.city,
    COUNT(*) FILTER (WHERE w.temperature > 30) AS hot_observations,
    COUNT(*) FILTER (WHERE w.temperature < 20) AS cold_observations
FROM weather_history w
JOIN city_dimension c ON c.city_id = w.city_id
GROUP BY c.city
HAVING COUNT(*) FILTER (WHERE w.temperature > 30)
     > COUNT(*) FILTER (WHERE w.temperature < 20)
ORDER BY hot_observations DESC;
