CREATE OR REPLACE TABLE `toronto-bikeshare-analysis.staging.station_info` AS
SELECT * FROM `toronto-bikeshare-analysis.raw_data.station_geo_data`
UNION ALL
SELECT
    ds.station_id,
    ds.station_name,
    NULL AS lat,  -- Set lat, lon, and capacity to NULL for missing stations
    NULL AS lon,
    NULL AS capacity
FROM
    `toronto-bikeshare-analysis.staging.VW_unique_trips_stations` AS ds
LEFT JOIN
    `toronto-bikeshare-analysis.raw_data.station_geo_data` AS si ON ds.station_id = si.station_id
WHERE
    si.station_id IS NULL;
