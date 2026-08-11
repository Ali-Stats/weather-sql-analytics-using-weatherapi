SELECT
    c.city,
    w.observed_at,
    w.temperature
FROM weather_history w
JOIN city_dimension c ON c.city_id = w.city_id
WHERE w.temperature > (
    SELECT AVG(w2.temperature)
    FROM weather_history w2
    WHERE w2.city_id = w.city_id
)
ORDER BY c.city, w.temperature DESC;
