## Pre-reqs 

Minikube is installed and has been validated 

## Enable ingress 

```
minikube addons enable ingress

```

### Add a Sample Ingress 

create a file called minikube-ingress.yml containing 

```
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: minikube-ingress
  annotations:
spec:
  rules:
  - host: hello.world
    http:
      paths:
      - path: /*
        backend:
          serviceName: node-hello-world
          servicePort: 9080

```
load this ingress as shown below 

```

kubectl apply -f minikube-ingress.yml

```


