# Weather SQL Analytics

## Project Overview

A portfolio-quality PostgreSQL analytics project built from weather data obtained from an external weather API, prepared with Python, and loaded into PostgreSQL.

The project focuses on:

- Relational data modeling
- Advanced PostgreSQL / SQL
- Data quality and validation
- CTEs, joins, subqueries and set operations
- Window functions and time-series analysis
- Analytical views
- Performance fundamentals
- Business-oriented weather questions
- A BI-ready analytical layer for **Tableau and Power BI**

> **Dashboard work is intentionally excluded from this repository phase and will be added after the SQL/database layer is finalized.**

## Data Lineage

```text
External Weather API
        |
        v
      Python
  extraction / preparation
        |
        v
   Prepared source files
        |
        v
    PostgreSQL
        |
        v
  Advanced SQL + Views
        |
     +--+--+
     |     |
 Tableau  Power BI
```

The current dataset was generated/prepared with Python and loaded into PostgreSQL manually. The automated API-to-PostgreSQL pipeline will be developed separately as **Portfolio #1 — Weather Data Engineering & API**.

## Dataset

Current source data used in this repository:

| Dataset | Rows | Grain |
|---|---:|---|
| City dimension source | 120 | One row per source city |
| Weather history | 3,600 | One observation per city/date |
| City alerts | 8 | One alert event |
| Current weather source | 126 | Current/API-style snapshot records |

The historical dataset covers **120 cities across 30 dates (2026-07-10 through 2026-08-08)**, with 30 observations per city.

## Data Quality / Modeling Decision

The source city dimension contained three placeholder city names (`PracticeCity_01`, `PracticeCity_02`, `PracticeCity_03`) while the weather history contained the actual cities `Guwahati`, `Jorhat`, and `Silchar`.

For the portfolio schema, the canonical city dimension is therefore rebuilt from the actual 120 cities represented in the weather history. New deterministic surrogate `city_id` values are assigned by sorted city name, and both weather history and alerts reference those keys.

The original uploaded source files are preserved under `data/raw/`. Clean, canonical CSVs used to build the portfolio schema are under `data/processed/`.

## Database Model

```text
city_dimension
     |
     | 1-to-many
     v
weather_history

city_dimension
     |
     | 1-to-many
     v
city_alerts
```

### `city_dimension`

One row per city.

- `city_id`
- `city`
- `state`
- `region`
- `latitude`
- `longitude`

### `weather_history`

One row per city and observation timestamp.

- `observation_id`
- `city_id`
- `observed_at`
- `temperature`
- `wind_speed`

### `city_alerts`

One row per alert event.

- `alert_id`
- `city_id`
- `alert_type`
- `alert_date`

## SQL Topics Covered

- Filtering and sorting
- Aggregations
- `GROUP BY` / `HAVING`
- Join types and join grain
- `UNION`, `UNION ALL`, `INTERSECT`, `EXCEPT`
- CTEs
- Subqueries and correlated subqueries
- `EXISTS` / `NOT EXISTS`
- Conditional aggregation
- `CASE`
- PostgreSQL `FILTER`
- Window functions
- `ROW_NUMBER`, `RANK`, `DENSE_RANK`, `NTILE`
- `PERCENT_RANK`, `CUME_DIST`
- `LAG`, `LEAD`
- Running and moving calculations
- Window frames
- Date/time analysis
- `DATE`, `DATE_TRUNC`, `EXTRACT`, `INTERVAL`
- NULL handling with `COALESCE` and `NULLIF`
- PostgreSQL-specific features
- Views and materialized views
- Constraints
- Indexes
- `EXPLAIN` / `EXPLAIN ANALYZE`
- Business-oriented analytical SQL

## Analytical Views

The final BI layer includes:

1. `vw_city_weather_summary` — one row per city
2. `vw_daily_weather` — one row per city/date
3. `vw_temperature_trends` — observation-level trends and window calculations
4. `vw_city_alert_summary` — one row per city with alert metrics
5. `vw_city_weather_alert_summary` — combined city-level weather + alert summary

These views are intended to become the common PostgreSQL source for both Tableau and Power BI.

## Repository Structure

```text
weather-sql-analytics/
├── README.md
├── data/
│   └── raw/
├── database/
│   ├── 01_create_tables.sql
│   ├── 02_seed_data.sql
│   ├── 03_constraints.sql
│   └── 04_indexes.sql
├── sql/
│   ├── 01_basics/
│   ├── 02_aggregations/
│   ├── 03_joins/
│   ├── 04_set_operations/
│   ├── 05_ctes/
│   ├── 06_subqueries/
│   ├── 07_window_functions/
│   ├── 08_date_time/
│   ├── 09_advanced/
│   └── 10_business_questions/
├── views/
├── docs/
├── tableau/
└── powerbi/
```

## Rebuild Order

Run the database files in this order:

```text
1. database/01_create_tables.sql
2. database/02_seed_data.sql
3. database/03_constraints.sql
4. database/04_indexes.sql
5. views/*.sql
```

Then validate:

```sql
SELECT COUNT(*) FROM city_dimension;
SELECT COUNT(*) FROM weather_history;
SELECT COUNT(*) FROM city_alerts;

SELECT *
FROM vw_city_weather_alert_summary
ORDER BY avg_temperature DESC;
```

Expected core row counts:

```text
city_dimension  → 120
weather_history → 3600
city_alerts     → 8
```

## Dashboard Phase

After the SQL layer is finalized:

### Tableau
PostgreSQL → analytical views → interactive weather intelligence dashboard.

### Power BI
PostgreSQL → analytical views → semantic model → interactive weather intelligence dashboard.

The same analytical questions will be implemented in both BI tools so the portfolio demonstrates cross-platform BI capability.
