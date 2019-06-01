#! /bin/bash

set -e
set -x

EXTERNAL_IP=$(curl -s -H "Metadata-Flavor: Google" \
http://metadata.google.internal/computeMetadata/v1/instance/network-interfaces/0/access-configs/0/external-ip)

kubeadm init --pod-network-cidr=192.168.0.0/16 \
--apiserver-cert-extra-sans=$EXTERNAL_IP

