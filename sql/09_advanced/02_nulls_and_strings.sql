SELECT
    city,
    COALESCE(region, 'Unknown') AS region
FROM city_dimension;

-- NULLIF is useful to avoid division by zero:
SELECT
    city,
    100.0 / NULLIF(COUNT(*), 0) AS example_ratio
FROM weather_history w
JOIN city_dimension c ON c.city_id = w.city_id
GROUP BY city;

SELECT
    city,
    UPPER(city) AS upper_city,
    LOWER(city) AS lower_city,
    LENGTH(city) AS city_name_length,
    TRIM(city) AS trimmed_city
FROM city_dimension;
