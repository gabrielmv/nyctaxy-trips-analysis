import boto3
import json
from time import sleep

stream_name = "ny-taxi-trips"

kinesis_client = boto3.client('kinesis', region_name='us-east-1')


def put_to_stream(thing_id, payload):
    print(payload)
    payload['thing_id'] = thing_id

    return kinesis_client.put_record(StreamName=stream_name,
                                     Data=json.dumps(payload),
                                     PartitionKey=thing_id)


if __name__ == "__main__":
    trips_path = ["../data/data-sample_data-nyctaxi-trips-2009-json_corrigido.json",
                  "../data/data-sample_data-nyctaxi-trips-2010-json_corrigido.json",
                  "../data/data-sample_data-nyctaxi-trips-2011-json_corrigido.json",
                  "../data/data-sample_data-nyctaxi-trips-2012-json_corrigido.json"]

    for path in trips_path:
        with open(path, 'r') as file:
            for line in file:
                payload = json.loads(file.readline())

                put_to_stream('aa-bb', payload=payload)
                sleep(5)
