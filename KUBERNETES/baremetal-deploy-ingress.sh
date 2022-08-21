#!/bin/bash
clear
echo

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
