kubectl auth can-i create pods \
  --namespace=propdevelopment-app \
  --as=admins \
  --as-group=admins

kubectl auth can-i get secrets \
  --namespace=propdevelopment-app \
  --as=admins

kubectl auth can-i get pods \
  --namespace=propdevelopment-app \
  --as=buyers
