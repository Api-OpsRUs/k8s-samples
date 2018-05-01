# Resource Quota Example

These set of files demonstrate how to create a "quota restriction" on a namespace.

## Testing out the Scenario:

`kubectl apply -f examples/resource-quota/create-resource-quota.yml`

> The above instruction will create a new namespace and create a resource quota under that namespace

To view the resource quota created

` kubectl describe quota mem-cpu-demo -n=resource-quota-demonstration-space`


Run the first pod which makes a request for 800 MB of RAM, this pod will install successfully because the resource quota would allow it.

`kubectl apply -f examples/resource-quota/02-my-first-pod.yml`

Now Run,
`kubectl apply -f examples/resource-quota/03-my-second-pod.yml`

The second pod will fail with the following error
>Error from server (Forbidden): error when creating "/Users/Rahul/dev/2018-sandbox/k8s-on-vagrant/examples/resource-quota/03-my-second-pod.yml": pods "quota-mem-cpu-demo-2" is forbidden: exceeded quota: mem-cpu-demo, requested: requests.memory=600Mi, used: requests.memory=600Mi, limited: requests.memory=1Gi

# Cleanup
`kubectl delete -f examples/resource-quota`
