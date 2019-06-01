#! /bin/bash
set -e
set -x

# Install prerequisites
apt-get update
apt-get install -y software-properties-common apt-transport-https curl docker.io

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl

kubeadm config images pull

poweroff
