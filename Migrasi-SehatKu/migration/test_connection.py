
import boto3
from botocore.exceptions import ClientError

dynamodb = boto3.resource(
    'dynamodb',
    endpoint_url='http://localhost:8000',
    region_name='us-east-1',
    aws_access_key_id='local',
    aws_secret_access_key='local'
)

try:
    print("Menghubungkan ke DynamoDB Local...")

    tables = list(dynamodb.tables.all())

    print("Koneksi berhasil!")
    print("Daftar tabel DynamoDB:")

    if tables:
        for table in tables:
            print("-", table.name)
    else:
        print("Belum ada tabel yang dibuat.")

except ClientError as e:
    print("Koneksi gagal:", e)

except Exception as e:
    print("Terjadi kesalahan:", e)
