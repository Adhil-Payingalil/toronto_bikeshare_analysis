CREATE OR REPLACE TABLE `toronto-bikeshare-analysis.staging.staging_trips` AS
  SELECT
    CAST(Trip_Id AS INT64) AS Trip_Id,
    CAST(Trip__Duration AS INT64) AS Trip_Duration,
    CAST(Start_Station_Id AS INT64) AS Start_Station_Id,
    CASE
      WHEN REGEXP_CONTAINS(Start_Time, r'\d+/\d+/\d+') THEN PARSE_TIMESTAMP("%m/%d/%Y %H:%M", Start_Time)
      WHEN REGEXP_CONTAINS(Start_Time, r'\d+-\d+-\d+') THEN PARSE_TIMESTAMP("%m-%d-%Y %H:%M", Start_Time)
      ELSE NULL
    END AS start_time_timestamp,
    Start_Station_Name,
    CASE 
      WHEN End_Station_Id = 'NULL' THEN NULL
      ELSE CAST(End_Station_Id AS INT64)
    END AS End_Station_Id,
    CASE
      WHEN REGEXP_CONTAINS(End_Time, r'\d+/\d+/\d+') THEN PARSE_TIMESTAMP("%m/%d/%Y %H:%M", End_Time)
      WHEN REGEXP_CONTAINS(End_Time, r'\d+-\d+-\d+') THEN PARSE_TIMESTAMP("%m-%d-%Y %H:%M", End_Time)
      ELSE NULL
    END AS end_time_timestamp,
    End_Station_Name,
    User_Type
  FROM
    `toronto-bikeshare-analysis.raw_data.bike_trips`
