import boto3
from boto3.dynamodb.conditions import Key, Attr

dynamodb = boto3.resource(
    'dynamodb',
    endpoint_url='http://localhost:8000',
    region_name='us-east-1',
    aws_access_key_id='local',
    aws_secret_access_key='local'
)

table = dynamodb.Table('laporan_keluhan')

status_dicari = 'menunggu'

print("===== PENGUJIAN SCAN =====")

scan_result = table.scan(
    FilterExpression=Attr('status').eq(status_dicari),
    ReturnConsumedCapacity='TOTAL'
)

print("Jumlah item diperiksa:", scan_result['ScannedCount'])
print("Jumlah item ditemukan:", scan_result['Count'])
print("Kapasitas baca:", scan_result['ConsumedCapacity'])

print("\n===== PENGUJIAN QUERY =====")

query_result = table.query(
    IndexName='status-index',
    KeyConditionExpression=Key('status').eq(status_dicari),
    ReturnConsumedCapacity='INDEXES'
)

print("Jumlah item diperiksa:", query_result['ScannedCount'])
print("Jumlah item ditemukan:", query_result['Count'])
print("Kapasitas baca:", query_result['ConsumedCapacity'])

print("\n===== DATA HASIL QUERY =====")

for item in query_result['Items']:
    print(item)
