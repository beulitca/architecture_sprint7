# Путь к CA Minikube
CA_CRT="${HOME}/.minikube/ca.crt"
CA_KEY="${HOME}/.minikube/ca.key"

# Папка для клиентов
OUT_DIR="./client-certs"
mkdir -p "${OUT_DIR}"

# Массив пользователей и их групп
declare -A USERS=(
  [buyer_user]="buyers"
  [admin_user]="admins"
)

# Основной кластер
CLUSTER_NAME="minikube"
NAMESPACE_DEFAULT="propdevelopment-app"

echo "Создаём сертификаты и обновляем kubeconfig..."

for USER in "${!USERS[@]}"; do
  GROUP="${USERS[$USER]}"
  KEY_PATH="${OUT_DIR}/${USER}.key"
  CSR_PATH="${OUT_DIR}/${USER}.csr"
  CRT_PATH="${OUT_DIR}/${USER}.crt"
  CTX_NAME="${USER}@${CLUSTER_NAME}"

  echo "==> Пользователь: ${USER}, группа: ${GROUP}"

  # 1) Генерируем приватный ключ
  openssl genrsa -out "${KEY_PATH}" 2048

  # 2) Создаём CSR с нужным CN и O
  openssl req -new -key "${KEY_PATH}" -out "${CSR_PATH}" \
    -subj "/CN=${USER}/O=${GROUP}"

  # 3) Подписываем CSR CA Minikube
  openssl x509 -req \
    -in "${CSR_PATH}" \
    -CAfile "${CA_CRT}" \
    -CAkey  "${CA_KEY}" \
    -CAcreateserial \
    -out   "${CRT_PATH}" \
    -days  365

  # 4) Добавляем в kubeconfig
  kubectl config set-credentials "${USER}" \
    --client-certificate="${CRT_PATH}" \
    --client-key="${KEY_PATH}"

  kubectl config set-context "${CTX_NAME}" \
    --cluster="${CLUSTER_NAME}" \
    --user="${USER}" \
    --namespace="${NAMESPACE_DEFAULT}"
done