WITH weather_sequence AS (
    SELECT
        city_id,
        observed_at,
        LAG(observed_at) OVER (
            PARTITION BY city_id
            ORDER BY observed_at
        ) AS previous_observed_at
    FROM weather_history
)
SELECT
    city_id,
    observed_at,
    previous_observed_at,
    observed_at - previous_observed_at AS time_gap
FROM weather_sequence
WHERE observed_at - previous_observed_at > INTERVAL '1 day'
ORDER BY time_gap DESC;
