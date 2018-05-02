# Apigee Microgateway Container
This repo contains the Dockerfile to build an image for the Apigee edge microgateway.

This builds container that runs a Micro Edge Gateway connects to an Apigee SaaS


Below are the steps to build a docker image.

#Docker image build steps
## Prerequisites
1. Docker installed on your machine.

## Build and Run docker image

### Build 

```
docker build . -t sidgs001/edge-micro-gateway:latest 
docker login 
docker push sidgs001/edge-micro-gateway:latest

```

## Run the microgateway 

The microgateway when run,  will perform the following actions   
  
1. Initialize Edge MG 
1. Configure Edge MG
1. Get Key 
1. Get Secret
1. Validate Edge MG
1. Run Edge MG 

### Kubernetes

#### Using kubectl on --namespace=development

```

kubectl replace --force -f k8s/development/config.yml --namespace=development --kubeconfig .kube/aws/config
kubectl replace --force -f k8s/development/secret.yml --namespace=development
kubectl replace --force -f k8s/development/deployment.yml --namespace=development
kubectl replace --force -f k8s/development/service.yml --namespace=development

```

The below enviroment configs are provided in the config.xml file 
- org : Apigee Edge Org name 
- env : Apigee Edge Env name
- url : organization's custom API URL (https://api.example.com)
- vhost: override virtualHosts (default: "default,secure")
 
The below enviroment configs are provided in the secret.xml file 
- username : Apigee Edge Ops Admin User Name 
- password : Apigee Edge Password 


### Docker 

#### Option 1 ( Using Command line Varaibles )

```
docker run sidgs001/edge-micro-gateway:latest  <org> <env> <username> <password>

```
- org : Apigee Edge Org name 
- env : Apigee Edge Env name
- username : Apigee Edge Ops Admin User Name 
- password : Apigee Edge Password 

#### Option 2 ( Using Env Variables )

```
docker run  -e ORG=<org> -e ENV=<env> -e USERNAME=<username> -e PASSWORD=<password>  \
    -e URL=<url> -e VHOSTS=<vhost> \
    sidgs001/edge-micro-gateway:latest

```
- org : Apigee Edge Org name 
- env : Apigee Edge Env name
- username : Apigee Edge Ops Admin User Name 
- password : Apigee Edge Password 
- url : organization's custom API URL (https://api.example.com)
- vhost: override virtualHosts (default: "default,secure")


## Validation 
curl -X POST 35.202.68.16:8080/hotel/example/v1/hotels/load -H "x-api-key: qzq7zP7FwcxOUdp0s7sNSVw2Vr10bUAz"

curl 35.202.68.16:8080/hotel/example/v1/hotels -H "x-api-key: qzq7zP7FwcxOUdp0s7sNSVw2Vr10bUAz"

## AWS k8s UI 

```
kubectl proxy --port=8011 --kubeconfig k8s/.kube/aws/config & 

# goto http://localhost:8011/ui
```

## Azure k8s UI 

```
kubectl proxy --port=8012 --kubeconfig k8s/.kube/aws/config & 

# goto http://localhost:8012/ui
```


curl -XPOST af7ae4f4331d011e899ca0e4a49680a5-498709229.us-east-1.elb.amazonaws.com:8080/hotel/example/v1/hotels/load  \
-H "x-api-key: qzq7zP7FwcxOUdp0s7sNSVw2Vr10bUAz"

curl  af7ae4f4331d011e899ca0e4a49680a5-498709229.us-east-1.elb.amazonaws.com:8080/hotel/example/v1/hotels  \
-H "x-api-key: qzq7zP7FwcxOUdp0s7sNSVw2Vr10bUAz"