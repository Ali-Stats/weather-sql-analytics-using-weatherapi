-- 01_create_tables.sql
-- Portfolio: Weather SQL Analytics
-- PostgreSQL schema for the normalized analytical database.

DROP TABLE IF EXISTS city_alerts CASCADE;
DROP TABLE IF EXISTS weather_history CASCADE;
DROP TABLE IF EXISTS city_dimension CASCADE;

CREATE TABLE city_dimension (
    city_id      INTEGER PRIMARY KEY,
    city         VARCHAR(100) NOT NULL UNIQUE,
    state        VARCHAR(100) NOT NULL,
    region       VARCHAR(50) NOT NULL,
    latitude     NUMERIC(9,5),
    longitude    NUMERIC(9,5),
    CONSTRAINT chk_city_latitude CHECK (latitude BETWEEN -90 AND 90),
    CONSTRAINT chk_city_longitude CHECK (longitude BETWEEN -180 AND 180)
);

CREATE TABLE weather_history (
    observation_id BIGINT PRIMARY KEY,
    city_id        INTEGER NOT NULL,
    observed_at    TIMESTAMP NOT NULL,
    temperature    NUMERIC(5,2) NOT NULL,
    wind_speed     NUMERIC(6,2) NOT NULL,
    CONSTRAINT fk_weather_city
        FOREIGN KEY (city_id) REFERENCES city_dimension(city_id),
    CONSTRAINT chk_temperature
        CHECK (temperature BETWEEN -100 AND 100),
    CONSTRAINT chk_wind_speed
        CHECK (wind_speed >= 0),
    CONSTRAINT uq_weather_city_time
        UNIQUE (city_id, observed_at)
);

CREATE TABLE city_alerts (
    alert_id    INTEGER PRIMARY KEY,
    city_id     INTEGER NOT NULL,
    alert_type  VARCHAR(100) NOT NULL,
    alert_date  DATE NOT NULL,
    CONSTRAINT fk_alert_city
        FOREIGN KEY (city_id) REFERENCES city_dimension(city_id),
    CONSTRAINT uq_alert
        UNIQUE (city_id, alert_type, alert_date)
);
