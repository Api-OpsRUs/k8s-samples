#!/bin/bash

if [ -z "$ORG" ]; then
    ORG=$1        
fi

if [ -z "$ENV" ]; then
    ENV=$2        
fi
if [ -z "$USERNAME" ]; then
    USERNAME=$3        
fi

if [ -z "$PASSWORD" ]; then
    PASSWORD=$4        
fi

PORT=$EDGE_PORT
if [ -z "$EDGE_PORT" ]; then 
    PORT=8080
fi 

if [ -z "$ORG"  ]; then
    Echo "Edge ORG is missing"
    exit 1        
fi


if [ -z "$ENV"  ]; then
    echo "Edge ENV is missing"
    exit 1        
fi


if [ -z "$USERNAME"  ]; then
    echo "Edge ORG is missing"
    exit 1        
fi


if [ -z "$PASSWORD"  ]; then
    echo "Edge PASSWORD  is missing"
    exit 1        
fi


echo "APIGEE ORG = $ORG "
echo "APIGEE ENV = $ENV "
echo "APIGEE USERNAME = $USERNAME "
echo "Vhosts:  $VHOSTS"
echo "Url: $URL"

TMP_FILE="/tmp/edge_micro.txt"
mg_key=""
mg_secret=""

rm -rf ~/.edgemicro/default.yaml

echo " Initialize Micro Gateway"
edgemicro init


if [ -d "./config/$ORG/$ENV/skip" ]; then 
   echo "Using a Customized initialized file "
   rm -rf ~/.edgemicro/default.yaml
   cp "./config/$ORG/$ENV/default.yaml" ~/.edgemicro/default.yaml
fi 

extrargs=""


if [ ! -z "$VHOSTS"  ] ; then
        extrargs="$extrargs --virtualHosts $VHOSTS" 
fi 

if [ ! -z "$URL"  ] ; then
         extrargs="$extrargs --url $URL" 
fi 

echo "Configure using:  -o $ORG -e $ENV -u $USERNAME $extrargs  "
edgemicro configure -o $ORG -e $ENV -u $USERNAME -p $PASSWORD $extrargs | tail -4 | sed -n 1,2p > $TMP_FILE

cat $TMP_FILE  | while read line; do
  # echo "line : $line"
  edge_key="`cut -d: -f1 <<<$line`"
  edge_key_value="`cut -d: -f2 <<<$line`"
  # echo " $edge_key and $edge_key_value "
  case $edge_key in
        key)
                echo "Setting key"
                echo "$edge_key_value" | sed -e 's/^[[:space:]]*//' > /tmp/key
                ;;
        secret)
                echo "Setting Secret"
                echo "$edge_key_value" | sed -e 's/^[[:space:]]*//'  > /tmp/secret
                ;;
        *)
                echo "Sorry, I don't understand"
                exit
                ;;
  esac
done

rm -rf $TMP_FILE

creds="-k `cat /tmp/key` -s `cat /tmp/secret`"

if [ ! -z "$EDGE_MICRO_VERIFY" ]; then 
        echo "Verify the Micro Gateway for -o $ORG -e $ENV $creds"
        edgemicro verify -o $ORG -e $ENV $creds
fi 

# Start Micro Gateway unless some one says dont 
if [ -z "$EDGE_MICRO_DONOT_START" ]; then 
        echo "Start Micro Gateway :  -o $ORG -r $PORT  -e $ENV $creds"
        edgemicro start -o $ORG  -e $ENV -r $PORT $creds 
fi 