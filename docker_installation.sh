echo "installing docker for Ubuntu"

sudo apt update
sudo apt install docker.io

sudo systemctl start docker
sudo systemctl enable docker

echo "installing kubernetes for Ubuntu"

sudo apt install apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
sudo apt install kubeadm kubelet kubectl kubernetes-cni

"initializing kubernetes admin"
sudo kubeadm init


