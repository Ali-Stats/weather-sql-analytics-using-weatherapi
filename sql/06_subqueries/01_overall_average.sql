-- Cities whose average temperature is above the overall average.
SELECT
    c.city,
    ROUND(AVG(w.temperature)::numeric, 2) AS city_avg_temperature
FROM city_dimension AS c
JOIN weather_history AS w
    ON c.city_id = w.city_id
GROUP BY c.city
HAVING AVG(w.temperature) > (
    SELECT AVG(temperature)
    FROM weather_history
)
ORDER BY city_avg_temperature DESC;
