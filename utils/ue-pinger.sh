#!/usr/bin/env bash

NAMESPACE=$1
ue=$2  # name of UE
count=$3

if [[ -z $NAMESPACE ]] || [[ -z $ue ]]; then
   echo "Usage: ./ping-script.sh <namespace> <ue> [<count>]"
   exit 1
fi

if [[ -z $count ]]; then
   echo "Pinging continuously ..."
   kubectl exec -it -n $NAMESPACE deployments/ueransim-$ue -- ping -I uesimtun0 www.google.ca 
else
   echo "Pinging $count times..."
   kubectl exec -it -n $NAMESPACE deployments/ueransim-$ue -- ping -I uesimtun0 www.google.ca -c $count
fi
