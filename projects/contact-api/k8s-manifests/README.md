# Installation 

Congrats now you are ready to run your services 

## Deploy your services 

```

kubectl create -f deploy.yml 

```

That should be all.. Lets check if our app are running 

```

kubectl get pods -o=wide 

# you should see the below 
# This means that you have 1 instance of your service running
 
NAME                                        READY     STATUS              RESTARTS   AGE       IP          NODE
contact-api-656f8b699b-pbvqz                  1/1       Running             0          4m        10.8.2.10   gke-cluster-1-default-pool-6b34ab77-lb5g
```

Now Lets expose it 

```

kubectl create -f service.yml 

```

That should be all . The Service is running 

```

kubectl get services -o=wide

# Result 

NAME            TYPE           CLUSTER-IP      EXTERNAL-IP     PORT(S)                      AGE       SELECTOR
contact-api       LoadBalancer   10.11.255.249   35.224.214.58   8090:30294/TCP               41m       app=contact-api

```

Your app contact-api is now exposed on externally on EXTERNAL-IP:PORT 

Lets load and query some data ....

```

curl -X POST 35.224.214.58:8090/example/v1/hotels/load

# now lets see what we loaded 

curl 35.224.214.58:8090/example/v1/hotels

```

You should see the below 

```
{"content":[
{"id":1,"name":"name - 10000","description":"Desc - 10000","city":"City - 10000","rating":0},
{"id":2,"name":"name - 10001","description":"Desc - 10001","city":"City - 10001","rating":1},
{"id":3,"name":"name - 10002","description":"Desc - 10002","city":"City - 10002","rating":2},
{"id":4,"name":"name - 10003","description":"Desc - 10003","city":"City - 10003","rating":3},
{"id":5,"name":"name - 10004","description":"Desc - 10004","city":"City - 10004","rating":4},
{"id":6,"name":"name - 10005","description":"Desc - 10005","city":"City - 10005","rating":0},
{"id":7,"name":"name - 10006","description":"Desc - 10006","city":"City - 10006","rating":1},
{"id":8,"name":"name - 10007","description":"Desc - 10007","city":"City - 10007","rating":2},
{"id":9,"name":"name - 10008","description":"Desc - 10008","city":"City - 10008","rating":3},
{"id":10,"name":"name - 10009","description":"Desc - 10009","city":"City - 10009","rating":4}],
"last":true,"totalElements":10,"totalPages":1,"first":true,"sort":null,"numberOfElements":10,"size":100,"number":0}

```