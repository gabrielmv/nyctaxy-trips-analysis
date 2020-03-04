import boto3
import json
from time import sleep

bucketname = "datasprint-test"
stream_name = "ny-taxi-trips"

s3 = boto3.resource('s3')
kinesis = boto3.client('kinesis', region_name='us-east-1')


def put_to_stream(thing_id, payload):
    print(payload)
    payload['thing_id'] = thing_id

    return kinesis.put_record(StreamName=stream_name,
                              Data=json.dumps(payload),
                              PartitionKey=thing_id)


if __name__ == "__main__":
    trips_files = ["nyctaxi-trips-2009.json",
                   "nyctaxi-trips-2010.json",
                   "nyctaxi-trips-2011.json",
                   "nyctaxi-trips-2012.json"]

    for file in trips_files:
        obj = s3.Object(bucketname, file)

        for line in obj.get()['Body']._raw_stream:
            payload = json.loads(line)
            print(payload)

            put_to_stream('aa-bb', payload=payload)
            sleep(5)
