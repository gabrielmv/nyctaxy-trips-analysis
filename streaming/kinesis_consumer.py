import boto3
import json
from time import sleep

stream_name = "ny-taxi-trips"

kinesis_client = boto3.client('kinesis', region_name='us-east-1')

response = kinesis_client.describe_stream(StreamName=stream_name)

my_shard_id = response['StreamDescription']['Shards'][0]['ShardId']

shard_iterator = kinesis_client.get_shard_iterator(StreamName=stream_name,
                                                   ShardId=my_shard_id,
                                                   ShardIteratorType='LATEST')

my_shard_iterator = shard_iterator['ShardIterator']

record_response = kinesis_client.get_records(ShardIterator=my_shard_iterator, Limit=2)

metric = {}
while 'NextShardIterator' in record_response:
    record_response = kinesis_client.get_records(ShardIterator=record_response['NextShardIterator'], Limit=2)

    if record_response['Records']:
        data = json.loads(record_response['Records'][0]['Data'])

        vendor = data['vendor_id']
        if vendor in metric.keys():
            metric[vendor]['passenger_count'] += int(data['passenger_count'])
            metric[vendor]['fare_revenue'] += float(data['fare_amount'])
        else:
            metric[vendor] = {}
            metric[vendor]['passenger_count'] = int(data['passenger_count'])
            metric[vendor]['fare_revenue'] = float(data['fare_amount'])

        print(metric)

    sleep(5)
