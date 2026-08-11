SELECT
    c.city,
    c.state,
    c.region,
    w.observed_at,
    w.temperature,
    w.wind_speed
FROM city_dimension AS c
LEFT JOIN weather_history AS w
    ON c.city_id = w.city_id
ORDER BY c.city, w.observed_at;
