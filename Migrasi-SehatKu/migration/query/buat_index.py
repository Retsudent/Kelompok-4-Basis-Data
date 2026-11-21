
import boto3

dynamodb = boto3.client(
    'dynamodb',
    endpoint_url='http://localhost:8000',
    region_name='us-east-1',
    aws_access_key_id='local',
    aws_secret_access_key='local'
)

try:
    dynamodb.update_table(
        TableName='laporan_keluhan',
        AttributeDefinitions=[
            {
                'AttributeName': 'status',
                'AttributeType': 'S'
            }
        ],
        GlobalSecondaryIndexUpdates=[
            {
                'Create': {
                    'IndexName': 'status-index',
                    'KeySchema': [
                        {
                            'AttributeName': 'status',
                            'KeyType': 'HASH'
                        }
                    ],
                    'Projection': {
                        'ProjectionType': 'ALL'
                    }
                }
            }
        ]
    )

    print("GSI status-index berhasil dibuat.")

except Exception as e:
    print("Gagal membuat index:", e)
