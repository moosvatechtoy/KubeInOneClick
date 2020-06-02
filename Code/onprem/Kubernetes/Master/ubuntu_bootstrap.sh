#!/bin/bash

# Install docker from Docker-ce repository
echo "`tput setaf 1``tput bold`[TASK 1] Install docker container engine `tput sgr0`"
apt-get update -y  >/dev/null 2>&1
apt-get install docker.io curl -y  >/dev/null 2>&1

# Set up the Docker daemon
echo "`tput setaf 1``tput bold`[TASK 2] Set up the Docker daemon `tput sgr0`"
cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

mkdir -p /etc/systemd/system/docker.service.d > /dev/null 2>&1

# Enable docker service
echo "`tput setaf 1``tput bold`[TASK 3] Enable and start docker service `tput sgr0`"
systemctl daemon-reload >/dev/null 2>&1
systemctl enable docker >/dev/null 2>&1
systemctl restart docker >/dev/null 2>&1

# Disable FireWall
echo "`tput setaf 1``tput bold`[TASK 4] Disable Firewall `tput sgr0`"
ufw disable 2>&1 
ufw reload 2>&1

# Disable swap
echo "`tput setaf 1``tput bold`[TASK 5] Disable and turn off SWAP `tput sgr0`"
sed -i '/swap/d' /etc/fstab 2>&1
swapoff -a 2>&1

# Add yum repo file for Kubernetes
echo "`tput setaf 1``tput bold`[TASK 6] Add apt repo file for kubernetes `tput sgr0`"
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add > /dev/null 2>&1
apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main" -y > /dev/null 2>&1

# Install Kubernetes
echo "`tput setaf 1``tput bold`[TASK 7] Install Kubernetes (kubeadm, kubelet and kubectl) `tput sgr0`"
apt-get update -y  >/dev/null 2>&1
apt-get install -y kubelet kubeadm kubectl kubernetes-cni  >/dev/null 2>&1

# Start and Enable kubelet service
echo "`tput setaf 1``tput bold`[TASK 8] Enable and start kubelet service `tput sgr0`"
systemctl enable kubelet >/dev/null 2>&1
systemctl start kubelet >/dev/null 2>&1
