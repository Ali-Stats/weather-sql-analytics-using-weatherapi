SELECT DISTINCT c.city
FROM city_alerts a
JOIN city_dimension c ON c.city_id = a.city_id
WHERE NOT EXISTS (
    SELECT 1
    FROM weather_history w
    WHERE w.city_id = a.city_id
);
