kubectl create rolebinding buyers-pod-reader \
  --namespace=propdevelopment-app \
  --role=general-pod-reader \
  --group=clients

kubectl create rolebinding admins-pod-writer \
  --namespace=propdevelopment-app \
  --role=general-pod-writer \
  --group=admins

kubectl create rolebinding admins-all-admins \
  --namespace=propdevelopment-app \
  --role=general-all-admin \
  --group=admins