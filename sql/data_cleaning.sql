-- ============================================================
-- Create Cleaned Dataset
-- Purpose: Combine the 12 monthly trip tables, remove exact
-- duplicate rows, exclude rides with non-positive durations,
-- and create variables used in the analysis.
-- ============================================================

CREATE OR REPLACE TABLE
  `omega-granite-504718-n9.cyclistic_case_study.cyclistic_cleaned` AS

WITH all_trips AS (

  SELECT * FROM `omega-granite-504718-n9.cyclistic_case_study.trips_202508`
  UNION ALL
  SELECT * FROM `omega-granite-504718-n9.cyclistic_case_study.trips_202509`
  UNION ALL
  SELECT * FROM `omega-granite-504718-n9.cyclistic_case_study.trips_202510`
  UNION ALL
  SELECT * FROM `omega-granite-504718-n9.cyclistic_case_study.trips_202511`
  UNION ALL
  SELECT * FROM `omega-granite-504718-n9.cyclistic_case_study.trips_202512`
  UNION ALL
  SELECT * FROM `omega-granite-504718-n9.cyclistic_case_study.trips_202601`
  UNION ALL
  SELECT * FROM `omega-granite-504718-n9.cyclistic_case_study.trips_202602`
  UNION ALL
  SELECT * FROM `omega-granite-504718-n9.cyclistic_case_study.trips_202603`
  UNION ALL
  SELECT * FROM `omega-granite-504718-n9.cyclistic_case_study.trips_202604`
  UNION ALL
  SELECT * FROM `omega-granite-504718-n9.cyclistic_case_study.trips_202605`
  UNION ALL
  SELECT * FROM `omega-granite-504718-n9.cyclistic_case_study.trips_202606`
  UNION ALL
  SELECT * FROM `omega-granite-504718-n9.cyclistic_case_study.trips_202607`
),

deduplicated AS (
  SELECT DISTINCT *
  FROM all_trips
)

SELECT
  *,
  TIMESTAMP_DIFF(ended_at, started_at, SECOND) AS ride_length_seconds,
  ROUND(
    TIMESTAMP_DIFF(ended_at, started_at, SECOND) / 60.0,
    2
  ) AS ride_length_minutes,
  EXTRACT(DAYOFWEEK FROM started_at) AS day_of_week

FROM deduplicated

WHERE TIMESTAMP_DIFF(ended_at, started_at, SECOND) > 0;

-- ============================================================
-- Final Validation
-- Purpose: Verify the cleaned dataset row count, confirm ride
-- IDs are unique, and check that no non-positive ride
-- durations remain.
-- ============================================================

SELECT
  COUNT(*) AS total_clean_rows,
  COUNT(DISTINCT ride_id) AS unique_ride_ids,
  COUNTIF(ride_length_seconds <= 0) AS invalid_duration_rows
FROM `omega-granite-504718-n9.cyclistic_case_study.cyclistic_cleaned`;
