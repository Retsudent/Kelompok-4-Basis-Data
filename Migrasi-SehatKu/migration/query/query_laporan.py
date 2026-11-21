
import boto3
from boto3.dynamodb.conditions import Key

dynamodb = boto3.resource(
    'dynamodb',
    endpoint_url='http://localhost:8000',
    region_name='us-east-1',
    aws_access_key_id='local',
    aws_secret_access_key='local'
)

table = dynamodb.Table('laporan_keluhan')

response = table.query(
    IndexName='status-index',
    KeyConditionExpression=Key('status').eq('menunggu')
)

print("===== HASIL PENCARIAN LAPORAN =====")
print("Status dicari: menunggu")
print("Jumlah laporan ditemukan:", response['Count'])

for item in response['Items']:
    print("--------------------------------")
    print("ID Laporan:", item.get('id_laporan'))
    print("Jenis Keluhan:", item.get('jenis_keluhan'))
    print("Status:", item.get('status'))
    print("Deskripsi:", item.get('deskripsi'))
