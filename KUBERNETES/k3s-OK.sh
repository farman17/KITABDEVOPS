#!/bin/bash
#SUMBER : https://blog.thenets.org/how-to-create-a-k3s-cluster-with-nginx-ingress-controller/

# Disable traefik
export INSTALL_K3S_EXEC="server --no-deploy traefik"

# Create k3s cluster
curl -sfL https://get.k3s.io | sh -s -

# admin credentials
# (probably the server is pointing to 127.0.0.1,
#  so you'll need to change to public/private
#  server ip)
#cat /etc/rancher/k3s/k3s.yaml

#How to add another k3s node?
#cat /var/lib/rancher/k3s/server/node-token

# Set variables
#export CONTROLLER_SERVER_IP="1.2.3.4"
#export K3S_TOKEN="CONTROLLER_TOKEN_HERE!!!"

# Add server as a worker node:
#curl -sfL https://get.k3s.io | K3S_URL=https://${CONTROLLER_SERVER_IP}:6443 sh

#How to install Nginx Ingress Controller
#kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.47.0/deploy/static/provider/baremetal/deploy.yaml

#create file ingress-controller-load-balancer.yaml:
#---

#apiVersion: v1
#kind: Service
#metadata:
  #name: ingress-nginx-controller-loadbalancer
  #namespace: ingress-nginx
#spec:
  #selector:
    #app.kubernetes.io/component: controller
    #app.kubernetes.io/instance: ingress-nginx
    #app.kubernetes.io/name: ingress-nginx
  #ports:
    #- name: http
      #port: 80
      #protocol: TCP
      #targetPort: 80
    #- name: https
      #port: 443
      #protocol: TCP
      #targetPort: 443
  #type: LoadBalancer
  
  
  #To add HPA just doing : kubectl autoscale deployment hello-world --min=2 --max=5 --cpu-percent=50
  
  

