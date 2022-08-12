#!/bin/bash
#SUMBER : https://adamtheautomator.com/kubernetes-dashboard/

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.2.0/aio/deploy/recommended.yaml
kubectl get all -n kubernetes-dashboard
KUBE_EDITOR="nano" kubectl edit service/kubernetes-dashboard -n kubernetes-dashboard

#By default, the service is only available internally to the cluster (ClusterIP) but changing to NodePort exposes the service to the outside. change to type: NodePort 
#after all edited, save that.

kubectl get pods --all-namespaces

#to delete use : kubectl delete pod kubernetes-dashboard-78c79f97b4-gjr2l -n kubernetes-dashboard

kubectl get svc --all-namespaces
kubectl create serviceaccount dashboard -n kubernetes-dashboard

#When you create a service account, a service account token also gets generated; this token is stored as a secret object.

kubectl get secret $(kubectl get serviceaccount dashboard -o jsonpath="{.secrets[0].name}") -o jsonpath="{.data.token}" | base64 --decode

kubectl create clusterrolebinding dashboard-admin -n kubernetes-dashboard  --clusterrole=cluster-admin  --serviceaccount=default:dashboard
