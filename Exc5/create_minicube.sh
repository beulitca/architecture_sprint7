# в powershell
minikube start --driver=docker
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
kubectl -n kube-system rollout status daemonset/calico-node
kubectl -n kube-system rollout status deployment/calico-kube-controllers
minikube delete
minikube start --driver=docker --network-plugin=cni --cni=calico --memory=4096 --cpus=2