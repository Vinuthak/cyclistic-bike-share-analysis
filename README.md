# cyclistic-bike-share-analysis

## Project Overview

This case study analyzes more than 6 million bike-share trips to understand how annual members and casual riders use Cyclistic bikes differently.

Using BigQuery and SQL, I cleaned, transformed, and analyzed 12 months of trip data from August 2025 through July 2026. I then used Google Sheets to create visualizations highlighting differences in ride duration, weekly and hourly usage patterns, monthly ridership, bike type, and start-station usage.

The goal of the analysis is to identify data-informed opportunities that could help Cyclistic encourage casual riders to become annual members.

## Business Question

**How do annual members and casual riders use Cyclistic bikes differently?**

The analysis focuses on identifying differences in riding behavior that could inform strategies for converting casual riders into annual members.

## Tools

- **BigQuery / SQL** — data validation, cleaning, transformation, and analysis
- **Google Sheets** — data visualization
- **Google Drive / Google Docs** — project organization and documentation

## Dataset

The analysis uses 12 months of historical bike-share trip data covering August 2025 through July 2026. The 12 monthly datasets originally contained 6,037,968 trip records.

The data includes ride IDs, bike types, start and end timestamps, station information, geographic coordinates, and rider type.

The dataset does not contain personally identifiable rider information, so the analysis compares trip behavior between rider categories rather than individual customers.
## Data Cleaning

Before analysis, I validated and cleaned the 12 monthly datasets in BigQuery.

Key preparation steps included:

- Confirming a consistent 13-column schema across all monthly tables
- Combining the 12 monthly tables using `UNION ALL`
- Identifying and removing 35 exact duplicate records
- Excluding 1,930 rides with non-positive ride durations
- Retaining rides with missing station information for analyses that did not require station data
- Creating ride-duration and day-of-week fields for analysis

The cleaned dataset contained 6,036,003 unique rides. A date-range check identified 128 valid rides that began on July 31, 2025; these were retained in the cleaned dataset but excluded from the final August 2025–July 2026 analysis period.
## Key Findings

- **Ride volume:** Annual members accounted for 64.38% of rides, compared with 35.62% for casual riders.
- **Ride duration:** Casual riders had a median ride duration of 11.12 minutes, compared with 8.55 minutes for members.
- **Weekly patterns:** Member rides were strongest on weekdays, while casual ridership increased toward the weekend, with Saturday recording the highest casual ride volume.
- **Time of day:** Member weekday usage showed pronounced morning and late-afternoon peaks, while casual usage increased more gradually throughout the day.
- **Monthly patterns:** Casual ridership showed greater variation across the year than member ridership.
- **Start stations:** The highest-volume start stations differed between casual riders and annual members.
- **Bike type:** Both groups predominantly used electric bikes, making bike preference a smaller differentiator than the temporal, duration, and location patterns.
 ## Recommendations

Based on the observed differences between rider groups, Cyclistic could:

1. Test targeted membership promotions during weekends and higher-ridership months when casual usage is high.
2. Prioritize membership marketing at high-volume casual start stations, particularly during periods of strong casual demand.
3. Tailor membership messaging toward casual riders taking longer-duration trips.

These strategies should be tested and evaluated using conversion rates and other relevant marketing metrics before broader implementation.
## Project Files

- [Full Case Study (PDF)](Cyclistic%20Bike-Share%20Case%20Study.pdf) — complete case study with analysis, visualizations, recommendations, and limitations
- [SQL Analysis](sql/analysis.sql) — SQL queries used to analyze rider behavior
- [Data Cleaning SQL](sql/data_cleaning.sql) — SQL used to create and validate the cleaned dataset
