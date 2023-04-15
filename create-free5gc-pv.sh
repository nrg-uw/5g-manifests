#!/bin/bash
# Create persistent volume for free5gc mongodb database
# Change name (i.e., free5gc-local-pv), path (i.e.,/home/n6saha/kubedata) 
# and nodeAffinity (i.e., nuc2). Make sure path exists on given node

# Define variables
PV_NAME="free5gc-local-pv"
PV_PATH="/home/n6saha/kubedata"
PV_NODE_AFFINITY="nuc2"

# Check if required variables are set
if [ -z "$PV_NAME" ] || [ -z "$PV_PATH" ] || [ -z "$PV_NODE_AFFINITY" ]; then
  echo "One or more required variables are not set."
  echo "Please set PV_NAME, PV_PATH, and PV_NODE_AFFINITY to valid values."
  exit 1
fi

# Create persistent volume
kubectl apply -f - <<EOF
apiVersion: v1
kind: PersistentVolume
metadata:
  name: $PV_NAME
  labels:
    project: free5gc
spec:
  capacity:
    storage: 8Gi
  accessModes:
  - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  local:
    path: $PV_PATH
  nodeAffinity:
    required:
      nodeSelectorTerms:
      - matchExpressions:
        - key: kubernetes.io/hostname
          operator: In
          values:
          - $PV_NODE_AFFINITY
EOF
