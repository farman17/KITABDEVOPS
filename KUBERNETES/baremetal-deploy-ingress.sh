#!/bin/bash
clear
echo

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/baremetal/deploy.yaml
#isinya sama dengan file baremetal-nginx-controller.yaml, berlaku jika ingin di apply manual


cat > ingress.yaml <<EOF 
spec:
  template:
    spec:
      hostNetwork: true
EOF
echo
echo

kubectl patch deployment ingress-nginx-controller -n ingress-nginx --patch "$(cat ingress.yaml)"
echo
echo
echo
echo "If you now run curl localhost we see at there is a web server running. That means success!"
echo
curl localhost 
echo
echo

kubectl create namespace production

#create secrets :
#echo -n 'admin' | base64
#YWRtaW4=
#echo -n '1f2d1e2e67df' | base64
#MWYyZDFlMmU2N2Rm
