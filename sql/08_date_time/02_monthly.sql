SELECT
    c.city,
    DATE_TRUNC('month', w.observed_at) AS month,
    ROUND(AVG(w.temperature)::numeric, 2) AS avg_temperature,
    MIN(w.temperature) AS min_temperature,
    MAX(w.temperature) AS max_temperature,
    COUNT(*) AS observations
FROM weather_history AS w
JOIN city_dimension AS c
    ON c.city_id = w.city_id
GROUP BY c.city, DATE_TRUNC('month', w.observed_at)
ORDER BY c.city, month;
