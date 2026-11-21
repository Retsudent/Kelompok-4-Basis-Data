import boto3

dynamodb = boto3.client(
    'dynamodb',
    endpoint_url='http://localhost:8000',
    region_name='us-east-1',
    aws_access_key_id='local',
    aws_secret_access_key='local'
)

response = dynamodb.describe_table(
    TableName='laporan_keluhan'
)

for index in response['Table'].get('GlobalSecondaryIndexes', []):
    print("Nama index:", index['IndexName'])
    print("Status:", index['IndexStatus'])
    print("Jumlah item:", index['ItemCount'])