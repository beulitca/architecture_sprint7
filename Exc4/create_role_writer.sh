NAMESPACE="propdevelopment-app"
ROLE_NAME="general-pod-writer"
VERBS_CSV="create,patch,update,delete"
RESOURCES_CSV="pods"

# Проверяем существование namespace
if ! kubectl get namespace "$NAMESPACE" &>/dev/null; then
  echo "Error: Namespace '$NAMESPACE' does not exist."
  exit 1
fi

# Формируем параметры
VERB_ARGS=()
IFS=',' read -ra VERBS <<< "$VERBS_CSV"
for verb in "${VERBS[@]}"; do
  VERB_ARGS+=(--verb="$verb")
done

RES_ARGS=()
IFS=',' read -ra RESOURCES <<< "$RESOURCES_CSV"
for res in "${RESOURCES[@]}"; do
  RES_ARGS+=(--resource="$res")
done

# Создаём роль
kubectl create role "$ROLE_NAME" \
  --namespace="$NAMESPACE" \
  "${VERB_ARGS[@]}" \
  "${RES_ARGS[@]}" \
  || echo "Role '$ROLE_NAME' in namespace '$NAMESPACE' already exists"