SELECT
    c.city,
    COUNT(*) AS total_observations,
    COUNT(*) FILTER (WHERE w.temperature > 30) AS hot_observations,
    COUNT(*) FILTER (WHERE w.temperature < 20) AS cold_observations,
    COUNT(*) FILTER (WHERE w.temperature BETWEEN 20 AND 30) AS normal_observations,
    ROUND(
        COUNT(*) FILTER (WHERE w.temperature > 30)::numeric
        / COUNT(*) * 100,
        2
    ) AS hot_percentage
FROM weather_history AS w
JOIN city_dimension AS c
    ON c.city_id = w.city_id
GROUP BY c.city
ORDER BY hot_percentage DESC;
