CREATE OR REPLACE VIEW `toronto-bikeshare-analysis.staging.VW_unique_trips_stations` AS
WITH start_stations AS (
  SELECT 
    Start_Station_Id AS station_id,
    Start_Station_Name AS station_name
  FROM 
    `toronto-bikeshare-analysis.staging.staging_trips`
  WHERE 
    Start_Station_Id IS NOT NULL
),

end_stations AS (
  SELECT 
    End_Station_ID AS station_id,
    End_Station_Name AS station_name
  FROM 
    `toronto-bikeshare-analysis.staging.staging_trips`
  WHERE 
    End_Station_ID IS NOT NULL
),

all_stations AS (
  SELECT * FROM start_stations
  UNION DISTINCT
  SELECT * FROM end_stations
)

SELECT
  station_id,
  Max(station_name) AS station_name
FROM
  all_stations
GROUP BY
  station_id
ORDER BY
  station_id;
