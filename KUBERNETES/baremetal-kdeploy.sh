#!/bin/bash
clear
echo

cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: tekkadan-deploy
  namespace: production
  labels:
    app: tekkadan
spec:
  replicas: 1
  selector:
    matchLabels:
      app: tekkadan
  template:
    metadata:
      labels:
        app: tekkadan
    spec:
      containers:
        - name: tekkadan-apps
          image: farman17/landingpage-1:35
          ports:
            - containerPort: 4000
EOF



cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  name: tekkadan-service
  namespace: production
  labels:
    app: tekkadan
spec:
  ports:
    - port: 4000
  selector:
    app: tekkadan
EOF


cat <<EOF | kubectl apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    kubernetes.io/ingress.class: nginx
    nginx.ingress.kubernetes.io/rewrite-target: /\$1
  name: tekkadan-ingress-rules
  namespace: production
spec:
  rules:
  - host: harbor.bangjago.my.id
    http:
      paths:
      - backend:
          service: 
            name: tekkadan-service
            port: 
              number: 4000
        path: /(.*)
        pathType: Prefix
EOF
