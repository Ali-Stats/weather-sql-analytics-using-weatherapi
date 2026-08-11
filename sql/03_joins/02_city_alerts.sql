SELECT
    c.city,
    c.state,
    a.alert_type,
    a.alert_date
FROM city_dimension AS c
LEFT JOIN city_alerts AS a
    ON c.city_id = a.city_id
ORDER BY c.city, a.alert_date;
