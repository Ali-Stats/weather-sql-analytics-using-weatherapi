# Architecture

## End-to-End Architecture

The Weather SQL Analytics project is organized into a layered analytical architecture.

```text
Prepared Weather Data
        |
        v
      Python
 data preparation
        |
        v
 Prepared CSV Data
        |
        v
    PostgreSQL
        |
        +-------------------+
        |                   |
        v                   v
 city_dimension       weather_history
        |                   |
        |                   |
        +---------+---------+
                  |
                  v
             city_alerts
                  |
                  v
          Relational Model
                  |
                  v
          Advanced SQL Layer
                  |
                  v
          Analytical Views
                  |
        +---------+---------+
        |                   |
        v                   v
     Tableau             Power BI
        |                   |
        v                   v
 Interactive           Power Query
 Dashboards                |
                            v
                    Semantic Model
                            |
                            v
                          DAX
                            |
                            v
                    Interactive Dashboards