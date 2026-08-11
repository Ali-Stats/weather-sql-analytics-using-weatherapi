# Data Dictionary

## city_dimension

| Column | Type | Description |
|---|---|---|
| city_id | INTEGER | Surrogate primary key |
| city | VARCHAR | City name |
| state | VARCHAR | State/administrative region |
| region | VARCHAR | Broad geographic region |
| latitude | NUMERIC | City latitude |
| longitude | NUMERIC | City longitude |

## weather_history

| Column | Type | Description |
|---|---|---|
| observation_id | BIGINT | Source observation identifier |
| city_id | INTEGER | Foreign key to city_dimension |
| observed_at | TIMESTAMP | Observation timestamp |
| temperature | NUMERIC | Temperature in °C |
| wind_speed | NUMERIC | Wind speed in source units |

## city_alerts

| Column | Type | Description |
|---|---|---|
| alert_id | INTEGER | Alert identifier |
| city_id | INTEGER | Foreign key to city_dimension |
| alert_type | VARCHAR | Alert category |
| alert_date | DATE | Alert date |
