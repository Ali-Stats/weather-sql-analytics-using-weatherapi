WITH weather_stats AS (
    SELECT
        city_id,
        COUNT(*) AS observations,
        ROUND(AVG(temperature)::numeric, 2) AS avg_temperature
    FROM weather_history
    GROUP BY city_id
)
SELECT
    c.city,
    c.state,
    w.observations,
    w.avg_temperature
FROM city_dimension AS c
LEFT JOIN weather_stats AS w
    ON c.city_id = w.city_id
ORDER BY c.city;
