#!/bin/bash

# Join worker nodes to the Kubernetes cluster
echo "`tput setaf 1``tput bold`[TASK 1] Join node to Kubernetes Cluster `tput sgr0`"
yum install -q -y sshpass >/dev/null 2>&1
sshpass -p "$2" scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $3@$1:/tmp/joincluster.sh /tmp/Worker/joincluster.sh 2>/dev/null
bash /tmp/Worker/joincluster.sh >/dev/null 2>&1
