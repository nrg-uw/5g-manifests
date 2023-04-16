#!/usr/bin/env bash

ue="$1"
ping_count="$2"
namespace="${3:-test}"

if [[ -z "$ue" ]]; then
    echo "Usage: $0 [ue] [ping_count] [namespace]"
    exit 1
fi

if [[ -z "$ping_count" ]]; then
    echo "Pinging continuously ..."
    kubectl exec -it -n "$namespace" "deployments/ueransim-$ue" -- ping -I "uesimtun0" "www.google.ca"
else
    echo "Pinging $ping_count times..."
    if ! kubectl exec -it -n "$namespace" "deployments/ueransim-$ue" -- ping -I "uesimtun0" "www.google.ca" -c "$ping_count"; then
        echo "Error: failed to execute ping command"
        exit 1
    fi
fi
