#!/bin/bash
if [ -z "$1" ]; then
  echo "Please provide a namespace as a parameter"
  exit 1
else
  NAMESPACE=$1
fi

kubectl delete pvc datadir-mongodb-0 -n "$NAMESPACE"
kubectl delete pv free5gc-local-pv
