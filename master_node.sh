echo "installing docker for Ubuntu"

sudo apt update
sudo apt install docker.io

sudo systemctl start docker
sudo systemctl enable docker

echo "installing kubernetes for Ubuntu"

sudo apt-get update && sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

#https://www.ibm.com/support/knowledgecenter/en/SSCKRH_1.0.2/platform/r_software_requirements_fci_kubernetes.html
echo "net.bridge.bridge-nf-call-iptables=1" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

echo "**********************************"
echo "copy the following line an execute it on the worker nodes"
sudo kubeadm init --pod-network-cidr=10.244.0.0/16
echo "**********************************"

echo "setting up the local kubeconfig"
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo "adding a network"
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
# "kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/bc79dd1505b0c8681ece4de4c0d86c5cd2643275/Documentation/kube-flannel.yml

echo "**********************"
echo "Now install kubernetes in the worker nodes"
