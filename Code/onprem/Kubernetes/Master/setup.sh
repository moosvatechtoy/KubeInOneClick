#!/bin/bash
if [ -f /etc/redhat-release ]; then
  sudo /tmp/Master/linux_bootstrap.sh
  sudo /tmp/Master/linux_bootstrap_kmaster.sh $1 $2 $3
fi

if [ -f /etc/lsb-release ]; then
  sudo /tmp/Master/ubuntu_bootstrap.sh
  sudo /tmp/Master/ubuntu_bootstrap_kmaster.sh $1 $2 $3
fi
