
import boto3

dynamodb = boto3.resource(
    'dynamodb',
    endpoint_url='http://localhost:8000',
    region_name='us-east-1',
    aws_access_key_id='local',
    aws_secret_access_key='local'
)

table = dynamodb.Table('laporan_keluhan')

users = {
    'admin01': 'admin',
    'petugas01': 'petugas',
    'pengguna01': 'pengguna'
}

permissions = {
    'admin': ['read', 'write'],
    'petugas': ['read'],
    'pengguna': []
}

def grant(role, permission):
    if permission not in permissions[role]:
        permissions[role].append(permission)

    print(f"GRANT: {permission} diberikan kepada {role}")


def revoke(role, permission):
    if permission in permissions[role]:
        permissions[role].remove(permission)

    print(f"REVOKE: {permission} dicabut dari {role}")


def akses_baca(username):

    if username not in users:
        print("AKSES DITOLAK: Akun tidak dikenal!")
        return

    role = users[username]

    if 'read' not in permissions[role]:
        print(f"AKSES DITOLAK: {username}")
        return

    response = table.scan()

    print(f"AKSES DITERIMA: {username}")
    print("Jumlah data:", response['Count'])


print("===== PENGUJIAN KONTROL AKSES =====")

akses_baca('pengguna01')

grant('pengguna', 'read')
akses_baca('pengguna01')

revoke('pengguna', 'read')
akses_baca('pengguna01')
