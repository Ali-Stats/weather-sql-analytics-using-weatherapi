-- UNION ALL: preserve duplicates
SELECT city FROM city_dimension
UNION ALL
SELECT city FROM city_alerts;

-- UNION: remove duplicates
SELECT city FROM city_dimension
UNION
SELECT city FROM city_alerts;

-- Cities present in both datasets
SELECT city FROM weather_history w
INTERSECT
SELECT city FROM city_alerts a;

-- Cities with weather but no alerts
SELECT city FROM weather_history
EXCEPT
SELECT city FROM city_alerts;

-- Cities in history but not in the city dimension
SELECT city FROM weather_history
EXCEPT
SELECT city FROM city_dimension;
