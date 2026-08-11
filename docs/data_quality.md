# Data Quality and Modeling Notes

## Source audit

- `city_dimensions`: 120 rows / 120 unique cities.
- `weather_history`: 3,600 rows / 120 unique cities.
- Each historical city has exactly 30 observations.
- Historical dates span 2026-07-10 through 2026-08-08.
- `city_alerts`: 8 alert events across 4 cities.
- The current-weather source contains 126 rows across 120 cities.

## Source mismatch

The source city dimension contains three placeholder cities:

- PracticeCity_01
- PracticeCity_02
- PracticeCity_03

The weather history contains three actual cities not present in that source dimension:

- Guwahati
- Jorhat
- Silchar

The final portfolio schema uses the 120 actual historical weather cities as the canonical dimension and assigns surrogate city keys. The original source files remain unchanged under `data/raw/`.

## Why this is documented

A portfolio project should show not only successful queries but also how data-quality problems were identified and resolved. The mismatch is therefore intentionally documented rather than hidden.
