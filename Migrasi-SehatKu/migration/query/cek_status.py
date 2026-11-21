import boto3

dynamodb = boto3.resource(
    'dynamodb',
    endpoint_url='http://localhost:8000',
    region_name='us-east-1',
    aws_access_key_id='local',
    aws_secret_access_key='local'
)

table = dynamodb.Table('laporan_keluhan')

response = table.scan(
    ProjectionExpression='#st',
    ExpressionAttributeNames={
        '#st': 'status'
    }
)

print("DAFTAR STATUS LAPORAN")

for item in response['Items']:
    print(item.get('status'))