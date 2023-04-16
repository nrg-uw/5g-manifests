#!/usr/bin/env bash

function_name="$1"
container_name="$2"
namespace="$3"

if [[ -z "$function_name" ]]; then
    echo "Usage: $0 [function_name] [container_name] [namespace]"
    exit 1
fi

namespace="${namespace:-test}"  # set default value to "test" if input is empty

if [[ -z "$container_name" ]]; then
    kubectl logs -f "deployments/ueransim-$function_name" -n "$namespace"
else
    kubectl logs -f "deployments/ueransim-$function_name" -c "$container_name" -n "$namespace"
fi
