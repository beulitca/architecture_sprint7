# Пользователь
openssl genrsa -out demo-client.key 2048
openssl req -new -key demo-client.key -out demo-client.csr \
  -subj "/CN=demo-client/O=clients"
openssl x509 -req \
  -in demo-client.csr \
  -CA ca.crt \
  -CAkey ca.key \
  -CAcreateserial \
  -out demo-client.crt \
  -days 365
  
# Админ
openssl genrsa -out demo-admin.key 2048
openssl req -new -key demo-admin.key -out demo-admin.csr \
  -subj "/CN=demo-admin/O=admins"
openssl x509 -req \
  -in demo-admin.csr \
  -CA ca.crt \
  -CAkey ca.key \
  -CAcreateserial \
  -out demo-admin.crt \
  -days 365 