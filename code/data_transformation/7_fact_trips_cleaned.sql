CREATE OR REPLACE VIEW `toronto-bikeshare-analysis.staging.fact_trips` AS
SELECT
    Trip_Id,
    Trip_Duration,
    Start_Station_Id,
    start_time_timestamp,
    DATE(start_time_timestamp) AS start_date,
    TIME(start_time_timestamp) AS start_time,
    TIME(TIMESTAMP_TRUNC(start_time_timestamp,HOUR)) AS start_hour,
    end_station_id,
    end_time_timestamp,
    DATE(end_time_timestamp) AS end_date,
    TIME(end_time_timestamp) AS end_time,
    User_Type
FROM
    `toronto-bikeshare-analysis.staging.staging_trips`
WHERE
    Start_Station_Id IN (SELECT station_id FROM `toronto-bikeshare-analysis.staging.station_info_cleaned`)
    AND End_Station_Id IN (SELECT station_id FROM `toronto-bikeshare-analysis.staging.station_info_cleaned`)
    AND end_station_id IS NOT NULL
    AND Trip_Duration !=0;
