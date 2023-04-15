#!/usr/bin/env bash

function_name=$1
container_name=$2

# set namespace
if [[ -z $3 ]]; then
    namespace="test"
else
    namespace=$3
fi

echo "Function name: $function_name"
echo "Container name: $container_name"

if [[ -z $container_name ]]; then
    kubectl logs -f deployments/free5gc-$function_name -n $namespace
else
    kubectl logs -f deployments/free5gc-$function_name -c $container_name -n $namespace
fi

