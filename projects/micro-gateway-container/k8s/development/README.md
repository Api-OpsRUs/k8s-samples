# Introduction 

This space is used to setup a kubernates development workspace 

## config.yml 

This file is used to define configuration for a namespace 
To create this configuration 

```

kubectl create -f config.yml 

```

## secrets.yml

This file is used to define the user and password used to connect Edge SaaS 

```

kubectl create -f secrets.yml 

```

## deployment.yml 

This file is used to create a POD that runs the microgateway using the enviroment configuration and secrets 

```

kubectl create -f deployment.yml 

```

## service.yml 

This file is used to deploy the microgteway as a service 

```

kubectl create -f service.yml 

```
