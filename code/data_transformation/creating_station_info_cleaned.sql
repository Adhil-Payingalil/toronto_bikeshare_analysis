CREATE OR REPLACE TABLE
  `toronto-bikeshare-analysis.staging.dim_station_info` AS
WITH
  ModeCapacity AS (
    SELECT
      CAPACITY
    FROM
      `toronto-bikeshare-analysis.staging.station_info`
    WHERE
      CAPACITY IS NOT NULL
    GROUP BY
      CAPACITY
    ORDER BY
      COUNT(*) DESC
    LIMIT 1
  )
SELECT
  station_id,
  name,
  lat,
  lon,
  IFNULL(
    si.CAPACITY,
    (
      SELECT
        CAPACITY
      FROM
        ModeCapacity
    )
  ) AS CAPACITY
FROM
  `toronto-bikeshare-analysis.staging.station_info` si
WHERE
  name IS NOT NULL;
