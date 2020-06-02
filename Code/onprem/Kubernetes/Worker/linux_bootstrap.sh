#!/bin/bash

# Update hosts file
echo "`tput setaf 1``tput bold`[TASK 1] Connecting to instance file `tput sgr0`"

# Install docker from Docker-ce repository
echo "`tput setaf 1``tput bold`[TASK 2] Install docker container engine `tput sgr0`"
yum install -y -q yum-utils device-mapper-persistent-data lvm2 > /dev/null 2>&1
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo > /dev/null 2>&1
yum install -y -q docker-ce >/dev/null 2>&1

# Enable docker service
echo "`tput setaf 1``tput bold`[TASK 3] Enable and start docker service `tput sgr0`"
systemctl enable docker >/dev/null 2>&1
systemctl start docker

# Disable SELinux
echo "`tput setaf 1``tput bold`[TASK 4] Disable SELinux `tput sgr0`"
setenforce 0
sed -i --follow-symlinks 's/^SELINUX=enforcing/SELINUX=disabled/' /etc/sysconfig/selinux

# Stop and disable firewalld
echo "`tput setaf 1``tput bold`[TASK 5] Stop and Disable firewalld `tput sgr0`"
systemctl disable firewalld >/dev/null 2>&1
systemctl stop firewalld

# Add sysctl settings
echo "`tput setaf 1``tput bold`[TASK 6] Add sysctl settings `tput sgr0`"
cat >>/etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system >/dev/null 2>&1

# Disable swap
echo "`tput setaf 1``tput bold`[TASK 7] Disable and turn off SWAP `tput sgr0`"
sed -i '/swap/d' /etc/fstab
swapoff -a

# Add yum repo file for Kubernetes
echo "`tput setaf 1``tput bold`[TASK 8] Add yum repo file for kubernetes `tput sgr0`"
cat >>/etc/yum.repos.d/kubernetes.repo<<EOF
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
        https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

# Install Kubernetes
echo "`tput setaf 1``tput bold`[TASK 9] Install Kubernetes (kubeadm, kubelet and kubectl) `tput sgr0`"
yum install -y -q kubeadm kubelet kubectl >/dev/null 2>&1

# Start and Enable kubelet service
echo "`tput setaf 1``tput bold`[TASK 10] Enable and start kubelet service `tput sgr0`"
systemctl enable kubelet >/dev/null 2>&1
systemctl start kubelet >/dev/null 2>&1
