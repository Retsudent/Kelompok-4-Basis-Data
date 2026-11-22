
import boto3

dynamodb = boto3.resource(
    'dynamodb',
    endpoint_url='http://localhost:8000',
    region_name='us-east-1',
    aws_access_key_id='dummy',
    aws_secret_access_key='dummy'
)

table = dynamodb.Table('laporan_keluhan')

roles = {}
users = {}

def create_role(role_name):
    roles[role_name] = []
    print(f"Role {role_name} berhasil dibuat.")

def create_user(username, role_name):
    if role_name not in roles:
        print("Role tidak ditemukan.")
        return

    users[username] = role_name
    print(f"User {username} berhasil dibuat.")

def grant(role_name, permission):
    if role_name in roles and permission not in roles[role_name]:
        roles[role_name].append(permission)
        print(f"GRANT {permission} TO {role_name}: berhasil.")

def inspect_access(username):
    if username not in users:
        print("User tidak ditemukan.")
        return

    role = users[username]
    print(f"\nUser       : {username}")
    print(f"Role       : {role}")
    print(f"Permission : {roles[role]}")

def authorize(username, permission):
    if username not in users:
        print("AKSES DITOLAK: User tidak ditemukan.")
        return False

    role = users[username]

    if permission in roles[role]:
        print(f"AKSES DITERIMA: {username} boleh {permission}.")
        return True

    print(f"AKSES DITOLAK: {username} tidak memiliki izin {permission}.")
    return False

def read_reports(username):
    if authorize(username, 'read'):
        result = table.scan()
        print("Jumlah laporan:", result['Count'])
        return

    print("Operasi baca dibatalkan.")

def revoke(role_name, permission):
    if role_name in roles and permission in roles[role_name]:
        roles[role_name].remove(permission)
        print(f"REVOKE {permission} FROM {role_name}: berhasil.")


print("\n=== 1. CREATE ROLE DAN USER ===")
create_role('report_role')
create_user('report_user', 'report_role')

print("\n=== 2. PENGUJIAN SEBELUM GRANT ===")
read_reports('report_user')

print("\n=== 3. GRANT HAK AKSES BACA ===")
grant('report_role', 'read')

print("\n=== 4. INSPEKSI HAK AKSES ===")
inspect_access('report_user')

print("\n=== 5. PENGUJIAN SETELAH GRANT ===")
read_reports('report_user')

print("\n=== 6. PENGUJIAN AKSES TULIS ===")
authorize('report_user', 'write')

print("\n=== 7. REVOKE HAK AKSES BACA ===")
revoke('report_role', 'read')

print("\n=== 8. INSPEKSI SETELAH REVOKE ===")
inspect_access('report_user')

print("\n=== 9. PENGUJIAN SETELAH REVOKE ===")
read_reports('report_user')
