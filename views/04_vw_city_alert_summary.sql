CREATE OR REPLACE VIEW vw_city_alert_summary AS
SELECT
    c.city_id,
    c.city,
    c.state,
    c.region,
    COUNT(a.alert_id) AS total_alerts,
    COUNT(*) FILTER (WHERE a.alert_type ILIKE '%heat%') AS heat_alerts,
    COUNT(*) FILTER (WHERE a.alert_type ILIKE '%rain%') AS rain_alerts,
    COUNT(*) FILTER (WHERE a.alert_type ILIKE '%wind%') AS wind_alerts,
    COUNT(*) FILTER (WHERE a.alert_type ILIKE '%storm%') AS storm_alerts,
    MIN(a.alert_date) AS first_alert_date,
    MAX(a.alert_date) AS latest_alert_date
FROM city_dimension c
LEFT JOIN city_alerts a
    ON c.city_id = a.city_id
GROUP BY c.city_id, c.city, c.state, c.region;
