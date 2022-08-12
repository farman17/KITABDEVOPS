#!/bin/bash
#SUMBER : https://itnext.io/setup-your-own-kubernetes-cluster-with-k3s-b527bf48e36a
#https://gladi.id/k3s-vs-k8s-apa-perbadinganya/
#https://computingforgeeks.com/install-kubernetes-on-ubuntu-using-k3s/
#https://itnext.io/setup-your-own-kubernetes-cluster-with-k3s-b527bf48e36a
curl -sfL https://get.k3s.io | sh -
#Get the node token which is needed in the next step:
#cat /var/lib/rancher/k3s/server/node-token
#On each machine that is going to be a worker node (JOINT WORKER) :
#curl -sfL https://get.k3s.io | K3S_URL=https://kubernetes01.domain.de:6443 K3S_TOKEN=<the-token-from-the-step-before> sh -
clear
sudo k3s kubectl get node

echo "SELESAI........"
