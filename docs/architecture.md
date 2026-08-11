# Architecture

```text
External Weather API
        |
        v
      Python
        |
        v
Prepared source data
        |
        v
   PostgreSQL
  /    |     \
City  Weather Alerts
Dim   History
  \     |     /
   \    |    /
    Analytical SQL
         |
      Views
         |
   +-----+-----+
   |           |
Tableau      Power BI
```

## Portfolio boundary

This repository is the SQL/analytics portfolio.

The automated API ingestion + FastAPI service will be developed separately as Portfolio #1.

The Tableau and Power BI dashboards will be developed after this database and SQL layer is finalized.
