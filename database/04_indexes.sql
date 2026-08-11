-- 04_indexes.sql
CREATE INDEX IF NOT EXISTS idx_weather_city
    ON weather_history(city_id);

CREATE INDEX IF NOT EXISTS idx_weather_observed_at
    ON weather_history(observed_at);

CREATE INDEX IF NOT EXISTS idx_weather_city_time
    ON weather_history(city_id, observed_at);

CREATE INDEX IF NOT EXISTS idx_alerts_city
    ON city_alerts(city_id);

CREATE INDEX IF NOT EXISTS idx_alerts_date
    ON city_alerts(alert_date);
