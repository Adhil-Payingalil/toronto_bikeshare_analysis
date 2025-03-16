CREATE OR REPLACE EXTERNAL TABLE `toronto-bikeshare-analysis.raw_data.bike_trips`
(
  Trip_Id INTEGER,
  Trip__Duration INTEGER,
  Start_Station_Id INTEGER,
  Start_Time STRING,
  Start_Station_Name STRING,
  End_Station_Id STRING,
  End_Time STRING,
  End_Station_Name STRING,
  Bike_Id INTEGER,
  User_Type STRING
)
OPTIONS (
  format = 'CSV',
  uris = ['gs://bike_share_toronto/source/*.csv'],
  skip_leading_rows = 1
);
