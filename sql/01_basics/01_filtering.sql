-- Basic filtering
SELECT city, observed_at, temperature
FROM weather_history
WHERE temperature > 30
ORDER BY temperature DESC;

SELECT city, observed_at, temperature
FROM weather_history
WHERE temperature BETWEEN 20 AND 30
ORDER BY temperature;

SELECT city
FROM city_dimension
WHERE region IN ('Northeast', 'North');

SELECT city
FROM city_dimension
WHERE city ILIKE 'g%';
