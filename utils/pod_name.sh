#!/usr/bin/env bash

function_name="$1"
namespace="${2:-test}"

if [[ -z "$function_name" ]]; then
    echo "Usage: $0 [function_name] [namespace]"
    exit 1
fi

if [[ "$function_name" == "gnb" || "$function_name" == "ue" ]]; then
    pod_name=$(kubectl get pods -n "$namespace" | egrep -i -o "ueransim-$function_name-[a-z0-9]+-[a-z0-9]+")
else
    pod_name=$(kubectl get pods -n "$namespace" | egrep -i -o "free5gc-$function_name-[a-z0-9]+-[a-z0-9]+")
fi

if [[ -z "$pod_name" ]]; then
    echo "Error: failed to get pod name"
    exit 1
fi

echo -n "$pod_name"

