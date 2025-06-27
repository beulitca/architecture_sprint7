# Параметры из командной строки
NAMESPACE="propdevelopment-app"
ROLE_NAME="general-pod-reader"
USER_NAME="buyers"
BINDING_NAME="reader-buyers-binding"

# Проверяем существование namespace
if ! kubectl get namespace "$NAMESPACE" &>/dev/null; then
  echo "Error: Namespace '$NAMESPACE' does not exist." >&2
  exit 1
fi

# Проверяем существование роли в namespace
if ! kubectl get role "$ROLE_NAME" -n "$NAMESPACE" &>/dev/null; then
  echo "Error: Role '$ROLE_NAME' not found in namespace '$NAMESPACE'." >&2
  exit 1
fi

# Создаём RoleBinding
kubectl create rolebinding "$BINDING_NAME" \
  --namespace="$NAMESPACE" \
  --role="$ROLE_NAME" \
  --user="$USER_NAME" \
  || echo "RoleBinding '$BINDING_NAME' already exists in namespace '$NAMESPACE'."

echo "✅ RoleBinding '$BINDING_NAME' for user '$USER_NAME' has been configured in namespace '$NAMESPACE'."