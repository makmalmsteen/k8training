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

echo "*********************************"
echo "Now copy the command that was generated in the master node to join this node to the network"
