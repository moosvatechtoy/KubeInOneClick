#!/bin/bash

# Initialize Kubernetes
echo "`tput setaf 1``tput bold`[TASK 1] Initialize Kubernetes Cluster `tput sgr0`"
kubeadm init --apiserver-advertise-address=$2 --pod-network-cidr=$3/16 >> /root/kubeinit.log 2>/dev/null

# Copy Kube admin config
echo "`tput setaf 1``tput bold`[TASK 2] Copy kube admin config to Vagrant user .kube directory `tput sgr0`"
mkdir /home/$1/.kube
cp /etc/kubernetes/admin.conf /home/$1/.kube/config
chown -R $1:$1 /home/$1/.kube

# Deploy Calico network
echo "`tput setaf 1``tput bold`[TASK 3] Deploy Calico network `tput sgr0`"
su - $1 -c "kubectl create -f https://docs.projectcalico.org/v3.11/manifests/calico.yaml"

# Generate Cluster join command
echo "`tput setaf 1``tput bold`[TASK 4] Generate and save cluster join command to /tmp/joincluster.sh `tput sgr0`"
kubeadm token create --print-join-command > /tmp/joincluster.sh
chmod 777 /tmp/joincluster.sh
