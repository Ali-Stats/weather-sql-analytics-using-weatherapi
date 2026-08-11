-- PostgreSQL FILTER
SELECT
    c.city,
    COUNT(*) FILTER (WHERE w.temperature > 30) AS hot_count
FROM weather_history w
JOIN city_dimension c ON c.city_id = w.city_id
GROUP BY c.city;

-- PostgreSQL ILIKE
SELECT city
FROM city_dimension
WHERE city ILIKE 'gu%';

-- generate_series: build a date spine
SELECT
    generate_series(
        (SELECT MIN(observed_at)::date FROM weather_history),
        (SELECT MAX(observed_at)::date FROM weather_history),
        INTERVAL '1 day'
    )::date AS observation_date;
