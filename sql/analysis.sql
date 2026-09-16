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

