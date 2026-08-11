-- Cities that have at least one alert.
SELECT c.city
FROM city_dimension AS c
WHERE EXISTS (
    SELECT 1
    FROM city_alerts AS a
    WHERE a.city_id = c.city_id
);

-- Cities with weather observations but no alerts.
SELECT DISTINCT c.city
FROM city_dimension AS c
WHERE EXISTS (
    SELECT 1
    FROM weather_history AS w
    WHERE w.city_id = c.city_id
)
AND NOT EXISTS (
    SELECT 1
    FROM city_alerts AS a
    WHERE a.city_id = c.city_id
);
