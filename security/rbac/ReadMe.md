# Pre Requisites

- Install Open SSL

# Preparing for the Scenario:

- Navigate to the directory which contains the file `cd examples/rbac`
- Create a new namespace for the demo `kubectl apply -f rbac-demo-namespace.yml`

# Create a Demo User (We will use Certificate Authentication with kubectl to identify the user)

- Generate the User's Private Key

`openssl genrsa -out user01.key 2048`

- Generate the CSR

`openssl req -new -key user01.key -out user01.csr -subj "/CN=user01/O=liquidhub"`

- Generate the cert

 `openssl x509 -req -in user01.csr -CA <LocationOfVagrantCertsDir>/vagrant/certs/ca/ca.pem -CAkey <LocationOfVagrantCertsDir>/vagrant/certs/ca/ca-key.pem -CAcreateserial -out user01.crt -days 365`

- Configure Kubectl Context

> `kubectl config set-credentials rbac-demo-user --client-certificate=user01.crt --client-key=user01.key`

> `kubectl config set-context rbac-demo-context --cluster=k8s-on-vagrant --namespace=rbac-demo-namespace --user=rbac-demo-user`

If you didn't edit the name of the cluster in cluster-descriptor.yml, it should be k8s-on-vagrant by default. If you edited the name of the cluster, use that name instead

# Testing RBAC

Run `kubectl --context=rbac-demo-context get pods` You now recieve an error saying

> Error from server (Forbidden): pods is forbidden: User "user01" cannot list pods in the namespace "rbac-demo-namespace"

This happened because the 'rbac-demo-user' does not have any privileges in the cluster,not yet.

Now, lets give the user some privileges in the cluster

 - Lets create a role first

> `kubectl apply -f deployment-manager-role.yml`

 - Now associate User01 with the role we just created

> `kubectl apply -f deployment-manager-rolebinding.yml`

# Verifying access

> `kubectl --context=rbac-demo-context get pods` will work
> `kubectl --context=rbac-demo-context get pods -n=default` will continue to give an error because the user is not entitled to the default namespace
