-- ============================================================
-- 1. Ride Volume by Rider Type
-- Purpose: Compare the overall number of rides taken by casual
-- riders and annual members during the final analysis period.
-- ============================================================

SELECT
  member_casual,
  COUNT(*) AS number_of_rides
FROM `omega-granite-504718-n9.cyclistic_case_study.cyclistic_cleaned`
WHERE started_at >= TIMESTAMP('2025-08-01')
  AND started_at < TIMESTAMP('2026-08-01')
GROUP BY member_casual
ORDER BY member_casual;

-- ============================================================
-- 2. Ride Duration
-- Purpose: Compare the typical ride duration of casual riders
-- and annual members using median ride duration.
-- ============================================================

SELECT
  member_casual,
  ROUND(
    APPROX_QUANTILES(ride_length_minutes, 2)[OFFSET(1)],
    2
  ) AS median_ride_minutes
FROM `omega-granite-504718-n9.cyclistic_case_study.cyclistic_cleaned`
WHERE started_at >= TIMESTAMP('2025-08-01')
  AND started_at < TIMESTAMP('2026-08-01')
GROUP BY member_casual
ORDER BY member_casual;

-- ============================================================
-- 3. Rides by Day of Week
-- Purpose: Compare weekly ride patterns between casual riders
-- and annual members.
-- ============================================================

SELECT
  CASE day_of_week
    WHEN 1 THEN 'Sunday'
    WHEN 2 THEN 'Monday'
    WHEN 3 THEN 'Tuesday'
    WHEN 4 THEN 'Wednesday'
    WHEN 5 THEN 'Thursday'
    WHEN 6 THEN 'Friday'
    WHEN 7 THEN 'Saturday'
  END AS day_name,
  member_casual,
  COUNT(*) AS number_of_rides
FROM `omega-granite-504718-n9.cyclistic_case_study.cyclistic_cleaned`
WHERE started_at >= TIMESTAMP('2025-08-01')
  AND started_at < TIMESTAMP('2026-08-01')
GROUP BY day_of_week, day_name, member_casual
ORDER BY day_of_week, member_casual;

-- ============================================================
-- 4. Weekday Rides by Hour
-- Purpose: Compare average hourly ride activity on weekdays
-- between casual riders and annual members.
-- ============================================================

WITH daily_hourly_rides AS (
  SELECT
    member_casual,
    DATE(started_at) AS ride_date,
    EXTRACT(HOUR FROM started_at) AS start_hour,
    COUNT(*) AS daily_rides
  FROM `omega-granite-504718-n9.cyclistic_case_study.cyclistic_cleaned`
  WHERE day_of_week IN (2, 3, 4, 5, 6)
    AND started_at >= TIMESTAMP('2025-08-01')
    AND started_at < TIMESTAMP('2026-08-01')
  GROUP BY member_casual, ride_date, start_hour
),

hourly_averages AS (
  SELECT
    member_casual,
    start_hour,
    AVG(daily_rides) AS avg_rides_per_day
  FROM daily_hourly_rides
  GROUP BY member_casual, start_hour
)

SELECT
  start_hour,
  ROUND(
    MAX(CASE
      WHEN member_casual = 'casual'
      THEN avg_rides_per_day
    END), 1
  ) AS casual_weekday,
  ROUND(
    MAX(CASE
      WHEN member_casual = 'member'
      THEN avg_rides_per_day
    END), 1
  ) AS member_weekday
FROM hourly_averages
GROUP BY start_hour
ORDER BY start_hour;
