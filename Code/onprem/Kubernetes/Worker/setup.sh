#!/bin/bash
if [ -f /etc/redhat-release ]; then
  sudo /tmp/Worker/linux_bootstrap.sh
  sudo /tmp/Worker/linux_bootstrap_kworker.sh $1 $2 $3
fi

if [ -f /etc/lsb-release ]; then
  sudo /tmp/Worker/ubuntu_bootstrap.sh
  sudo /tmp/Worker/ubuntu_bootstrap_kworker.sh $1 $2 $3
fi
