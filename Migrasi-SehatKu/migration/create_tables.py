
import boto3
from botocore.exceptions import ClientError

dynamodb = boto3.resource(
    'dynamodb',
    endpoint_url='http://localhost:8000',
    region_name='us-east-1',
    aws_access_key_id='local',
    aws_secret_access_key='local'
)

tables = {
    'pengguna': 'id_pengguna',
    'laporan_keluhan': 'id_laporan',
    'riwayat_status_laporan': 'id_riwayat',
    'verifikasi_laporan': 'id_verifikasi',
    'tindak_lanjut': 'id_tindak_lanjut',
    'notifikasi': 'id_notifikasi',
    'evaluasi_kesehatan': 'id_evaluasi',
    'konten_edukasi': 'id_edukasi'
}

print("MEMBUAT TABEL DYNAMODB SEHATKU")
print("--------------------------------")

for table_name, primary_key in tables.items():

    try:
        table = dynamodb.create_table(
            TableName=table_name,
            KeySchema=[
                {
                    'AttributeName': primary_key,
                    'KeyType': 'HASH'
                }
            ],
            AttributeDefinitions=[
                {
                    'AttributeName': primary_key,
                    'AttributeType': 'N'
                }
            ],
            BillingMode='PAY_PER_REQUEST'
        )

        table.wait_until_exists()

        print(f"[BERHASIL] Tabel {table_name} dibuat")

    except dynamodb.meta.client.exceptions.ResourceInUseException:
        print(f"[SUDAH ADA] Tabel {table_name}")

    except ClientError as e:
        print(f"[GAGAL] {table_name}: {e}")

print("--------------------------------")
print("Proses pembuatan tabel selesai!")
