-- Source audit queries used before finalizing the model.

SELECT COUNT(*) AS city_rows, COUNT(DISTINCT city) AS unique_cities
FROM city_dimension;

SELECT COUNT(*) AS weather_rows, COUNT(DISTINCT city) AS unique_weather_cities
FROM weather_history;

SELECT city, COUNT(*) AS observations,
       MIN(observed_at) AS first_observation,
       MAX(observed_at) AS last_observation
FROM weather_history
GROUP BY city
ORDER BY city;

SELECT COUNT(*) AS alert_rows, COUNT(DISTINCT city) AS alert_cities
FROM city_alerts;

-- Cities in history but not source dimension
SELECT DISTINCT w.city
FROM weather_history w
LEFT JOIN city_dimension c ON c.city = w.city
WHERE c.city IS NULL;

-- Cities in source dimension but not history
SELECT c.city
FROM city_dimension c
LEFT JOIN weather_history w ON w.city = c.city
WHERE w.city IS NULL;
