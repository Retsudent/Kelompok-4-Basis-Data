
import boto3

dynamodb = boto3.client(
    'dynamodb',
    endpoint_url='http://localhost:8000',
    region_name='us-east-1',
    aws_access_key_id='local',
    aws_secret_access_key='local'
)

response = dynamodb.list_tables()

print("DAFTAR TABEL DYNAMODB")
print("======================")

for tabel in response['TableNames']:
    print(tabel)

print("======================")
print("Total tabel:", len(response['TableNames']))
