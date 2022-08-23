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
  replicas: 2
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
            - containerPort: 80
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
    - port: 80
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
              number: 80
        path: /(.*)
        pathType: Prefix
EOF

cat <<EOF | kubectl apply -f -
apiVersion: autoscaling/v2beta1
kind: HorizontalPodAutoscaler
metadata:
  name: tekkadan-hpa
  namespace: production
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: tekkadan-deploy
  minReplicas: 2
  maxReplicas: 5
  metrics:
  - type: Resource
    resource:
      name: cpu
      targetAverageUtilization: 1
  - type: Resource
    resource:
      name: memory
      targetAverageValue: 1Mi


kubectl get pods -n production
 echo
 echo
 kubectl get deployment -n production
 echo
 echo
 kubectl get svc -n production
 echo
 echo
 kubectl get ingress -n production
 echo
 echo
 kubectl get hpa -n production
