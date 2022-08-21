#!/bin/bash
clear
echo

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/baremetal/deploy.yaml

cat > ingress.yaml <<EOF 
spec:
  template:
    spec:
      hostNetwork: true
EOF
echo
echo

kubectl patch deployment ingress-nginx-controller -n ingress-nginx --patch "$(cat ingress.yaml)"

clear
curl localhost 
echo
echo

kubectl create namespace production
