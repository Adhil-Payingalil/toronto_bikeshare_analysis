UPDATE
    `toronto-bikeshare-analysis.staging.station_info` AS si
SET
    si.lat = gs.lat,
    si.lon = gs.lon
FROM
    `toronto-bikeshare-analysis.staging.geocoded_stations` AS gs
WHERE
    si.station_id = gs.station_id
    AND si.lat IS NULL  -- Only update rows where lat and lon are currently NULL
    AND si.lon IS NULL;
