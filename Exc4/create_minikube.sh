minikube delete
minikube start --driver=docker --cpus=2 --memory=2048mb
minikube kubectl -- get nodes
kubectl get ns
kubectl create namespace propdevelopment-app
kubectl get pods -n propdevelopment-app
kubectl config set-context --current --namespace=propdevelopment-app
## Создание пользователей
# Сертификат
wsl -d Ubuntu 
sudo apt update  
sudo apt install openssl -y 
# Создаем директорию для сертификата для пользователя: \\wsl$\Ubuntu\home\user\minikube-ca 
mkdir -p ~/minikube-ca
cp /mnt/c/Users/beuli/.minikube/ca.crt C:\Git\architecture-sprint-7\Exc4\minikube-ca
cp /mnt/c/Users/beuli/.minikube/ca.key C:\Git\architecture-sprint-7\Exc4\minikube-ca
# Объединяем описание кластера из WSL и кастомное
cp /mnt/c/Users/<WindowsUser>/.kube/config ~/.kube/config
export KUBECONFIG=~/.kube/config:/mnt/c/Users/<WindowsUser>/.kube/config
export KUBECONFIG=~/.kube/config:/mnt/c/Users/beuli/.kube/config
kubectl config view --flatten > ~/.kube/config
unset KUBECONFIG
# Сделать скрипт исполняемым и запустить
chmod +x create_users.sh
./create_users.sh

