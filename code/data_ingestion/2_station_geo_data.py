import requests
from google.cloud import bigquery

def load_station_information_to_bigquery(project_id, dataset_id, table_id):

    url = "https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_information"

    try:
        response = requests.get(url)
        response.raise_for_status() 
        data = response.json()

        stations = data["data"]["stations"]

        # Define the BigQuery schema
        schema = [
            bigquery.SchemaField("station_id", "INTEGER", mode="REQUIRED"),
            bigquery.SchemaField("name", "STRING"),
            bigquery.SchemaField("lat", "FLOAT"),
            bigquery.SchemaField("lon", "FLOAT"),
            bigquery.SchemaField("capacity", "INTEGER")
        ]

        # Create a BigQuery client
        client = bigquery.Client(project=project_id)
        dataset_ref = client.dataset(dataset_id)
        table_ref = dataset_ref.table(table_id)

        # Create the BigQuery table
        table = bigquery.Table(table_ref, schema=schema)
        table = client.create_table(table, exists_ok=True)  # Create if it doesn't exist

        # Prepare the data for BigQuery load
        rows_to_insert = []
        for station in stations:
            rows_to_insert.append({
                "station_id": station.get("station_id"),
                "name": station.get("name"),
                "lat": station.get("lat"),
                "lon": station.get("lon"),
                "capacity": station.get("capacity")
            })

        # Load the data into BigQuery
        errors = client.insert_rows_json(table_ref, rows_to_insert)

        if errors:
            print(f"Errors occurred while inserting rows: {errors}")
        else:
            print(f"Data successfully loaded into {project_id}.{dataset_id}.{table_id}")

    except requests.exceptions.RequestException as e:
        print(f"Error fetching data: {e}")
    except KeyError as e:
        print(f"Error parsing JSON: {e}")
    except Exception as e:
        print(f"An unexpected error occurred: {e}")


load_station_information_to_bigquery(project_id, dataset_id, table_id)
project_id = "toronto-bikeshare-analysis"
dataset_id = "raw_data"
table_id = "station_geo_data"

load_station_information_to_bigquery(project_id, dataset_id, table_id)
