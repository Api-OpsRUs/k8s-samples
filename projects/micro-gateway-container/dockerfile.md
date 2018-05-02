# Setting up edge micro 

1. Init the edge gateway 
1. 

```
edgemicro configure -o org -e env -u username -p password | tail -4 | sed -n 1,2p > edge-micro-secret.txt
```

The above command will configure the edge micro gateway and store the key and secret on a edge-micro-secret.txt file 