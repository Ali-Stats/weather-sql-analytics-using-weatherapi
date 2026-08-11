-- 03_constraints.sql
-- Portfolio: Weather SQL Analytics
-- Constraint verification and integrity checks.
--
-- The actual PRIMARY KEY, FOREIGN KEY, UNIQUE, NOT NULL and CHECK
-- constraints are intentionally declared in 01_create_tables.sql.
-- This file validates that those rules are present and checks the
-- loaded data for integrity issues.

-- ============================================================
-- 1. Verify declared constraints
-- ============================================================

SELECT
    tc.table_name,
    tc.constraint_name,
    tc.constraint_type
FROM information_schema.table_constraints AS tc
WHERE tc.table_schema = 'public'
  AND tc.table_name IN (
      'city_dimension',
      'weather_history',
      'city_alerts'
  )
ORDER BY
    tc.table_name,
    tc.constraint_type,
    tc.constraint_name;


-- ============================================================
-- 2. Check for duplicate cities
-- Expected result: 0 rows
-- ============================================================

SELECT
    city,
    COUNT(*) AS duplicate_count
FROM city_dimension
GROUP BY city
HAVING COUNT(*) > 1;


-- ============================================================
-- 3. Check for orphan weather records
-- Expected result: 0 rows
-- ============================================================

SELECT
    w.observation_id,
    w.city_id
FROM weather_history AS w
LEFT JOIN city_dimension AS c
    ON w.city_id = c.city_id
WHERE c.city_id IS NULL;


-- ============================================================
-- 4. Check for orphan alert records
-- Expected result: 0 rows
-- ============================================================

SELECT
    a.alert_id,
    a.city_id
FROM city_alerts AS a
LEFT JOIN city_dimension AS c
    ON a.city_id = c.city_id
WHERE c.city_id IS NULL;


-- ============================================================
-- 5. Check duplicate weather city/timestamp combinations
-- Expected result: 0 rows
-- ============================================================

SELECT
    city_id,
    observed_at,
    COUNT(*) AS duplicate_count
FROM weather_history
GROUP BY
    city_id,
    observed_at
HAVING COUNT(*) > 1;


-- ============================================================
-- 6. Check duplicate city/type/date alerts
-- Expected result: 0 rows
-- ============================================================

SELECT
    city_id,
    alert_type,
    alert_date,
    COUNT(*) AS duplicate_count
FROM city_alerts
GROUP BY
    city_id,
    alert_type,
    alert_date
HAVING COUNT(*) > 1;


-- ============================================================
-- 7. Check invalid coordinates
-- Expected result: 0 rows
-- ============================================================

SELECT *
FROM city_dimension
WHERE latitude NOT BETWEEN -90 AND 90
   OR longitude NOT BETWEEN -180 AND 180;


-- ============================================================
-- 8. Check invalid weather values
-- Expected result: 0 rows
-- ============================================================

SELECT *
FROM weather_history
WHERE temperature NOT BETWEEN -100 AND 100
   OR wind_speed < 0;
