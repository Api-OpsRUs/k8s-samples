
# K8S AWS Credentials 

- Username: admin 
- Password : CxLB8FpdQbAjq3YSXQduNdkXufJ7O1RA
- Api server Location : https://34.200.219.67:6443


# Steps to log Kubernates on AWS 

## add a username and password 

```
kubectl config set-credentials admin/34.200.219.67 --username=admin \
   --password=CxLB8FpdQbAjq3YSXQduNdkXufJ7O1RA 
```

## add a Kubernetes API server cluster 


```
kubectl config set-cluster 34.200.219.67 \ 
	--insecure-skip-tls-verify=true \
	--server=https://34.200.219.67:6443
```


## setup the context 

```
kubectl config set-context admin/34.200.219.67/kubeuser \
	--user=admin/34.200.219.67 \
	--namespace=default \
	--cluster=34.200.219.67  
```

## use the context 

```
kubectl config use-context admin/34.200.219.67/kubeuser
```

## Start Kube Admin UI

```
kubectl proxy & 
```

Open a browser http://localhost:8001 

# Refernces 

- https://docs.bitnami.com/kubernetes/how-to/configure-rbac-in-your-kubernetes-cluster/ 
- http://blog.christianposta.com/kubernetes/logging-into-a-kubernetes-cluster-with-kubectl/
