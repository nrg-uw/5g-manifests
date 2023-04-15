#!/usr/bin/env bash

function_name=$1

# set namespace
if [[ -z $2 ]]; then
    namespace="test"
else
    namespace=$2
fi

echo "Function name: $function_name"

if [[ -z $container_name ]]; then
    kubectl logs -f deployments/ueransim-$function_name -n $namespace
fi

