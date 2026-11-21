
import pymysql
import boto3
import json
from datetime import date, datetime

mysql_db = pymysql.connect(
    host='localhost',
    user='root',
    password='',
    database='sistem_sehatku',
    port=3306,
    cursorclass=pymysql.cursors.DictCursor
)

dynamodb = boto3.resource(
    'dynamodb',
    endpoint_url='http://localhost:8000',
    region_name='us-east-1',
    aws_access_key_id='local',
    aws_secret_access_key='local'
)


tables = [
    'pengguna',
    'laporan_keluhan',
    'riwayat_status_laporan',
    'verifikasi_laporan',
    'tindak_lanjut',
    'notifikasi',
    'evaluasi_kesehatan',
    'konten_edukasi'
]


def convert_data(data):

    for key, value in data.items():

        if isinstance(value, (datetime, date)):
            data[key] = value.isoformat()

        elif key == 'detail_fasilitas' and isinstance(value, str):
            try:
                data[key] = json.loads(value)
            except json.JSONDecodeError:
                pass

    return data


print("================================")
print(" MIGRASI MYSQL KE DYNAMODB")
print("================================")

total_data = 0

try:

    with mysql_db.cursor() as cursor:

        for table_name in tables:

            print(f"\nMemproses tabel: {table_name}")

            cursor.execute(f"SELECT * FROM `{table_name}`")
            rows = cursor.fetchall()

            dynamo_table = dynamodb.Table(table_name)

            if rows:

                with dynamo_table.batch_writer() as batch:

                    for row in rows:

                        item = convert_data(dict(row))

                        batch.put_item(Item=item)

            jumlah = len(rows)
            total_data += jumlah

            print(f"Berhasil: {jumlah} data")

    print("\n================================")
    print(" MIGRASI SELESAI")
    print("================================")
    print(f"Total data dimigrasikan: {total_data}")

except Exception as e:

    print("\nMIGRASI GAGAL!")
    print("Penyebab:", e)

finally:

    mysql_db.close()
