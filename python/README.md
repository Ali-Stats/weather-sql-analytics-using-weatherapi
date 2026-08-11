# Python Weather API Ingestion

This module contains the Python application used to retrieve weather data from the Open-Meteo APIs and store the retrieved weather information in PostgreSQL.

## Data Flow

City entered by the user
→ Open-Meteo Geocoding API
→ Latitude and Longitude
→ Open-Meteo Weather API
→ Temperature, Wind Speed and Observation Time
→ PostgreSQL

## Components

| File | Responsibility |
|---|---|
| `src/main.py` | Application entry point and workflow orchestration |
| `src/geocoding.py` | Resolves city names into geographic coordinates |
| `src/weather.py` | Retrieves weather information |
| `src/db_handler.py` | Saves weather data to PostgreSQL |
| `src/database.py` | Creates the PostgreSQL database connection |
| `src/config.py` | Stores API endpoints and configuration |

## APIs

The project uses:

- Open-Meteo Geocoding API
- Open-Meteo Weather API

Timezone used:

`Asia/Kolkata`

## Configuration

Database credentials are supplied through environment variables.

Create a local `.env` file using `.env.example` as a reference.

Real credentials and `.env` files must never be committed to GitHub.

## Role in the Portfolio

The Python application represents the data acquisition component of the project.

For the SQL analytics layer, prepared weather datasets are loaded into PostgreSQL and analyzed using SQL.

The resulting analytical views are designed for consumption by Tableau and Power BI.