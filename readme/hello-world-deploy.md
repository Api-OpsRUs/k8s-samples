## Pre-reqs 

Minikube is started and running 

## 

## sidgs001/node-hello-world

### Run on Docker 

```
docker run -p 9080:9080  -d sidgs001/node-hello-world

curl localhost:9080

Output: Hello World 
```

### Run the container as a K8S Svc

```
echo 'run the service'
kubectl run node-hello-world --image=sidgs001/node-hello-world:latest --port=9080

echo 'expose the service' 
kubectl expose deployment node-hello-world --type=NodePort

```

## Service Location 

Run the below command

$ minikube services list 

```

|-----------|------------------|----------------------------|
| NAMESPACE |       NAME       |            URL             |
|-----------|------------------|----------------------------|
| default   | node-hello-world | http://172.20.20.232:31333 |
|-----------|------------------|----------------------------|

```

