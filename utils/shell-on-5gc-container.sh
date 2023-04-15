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

shell=""
if [[ $function_name == "amf" || $function_name == "smf" || $function_name == "smf2" ]]; then
    shell=bash
else
    shell=bash
fi

if [[ $function_name == "gnb" || $function_name == *"ue"* ]]; then
    pod_name=$(kubectl get pods -n $namespace | egrep -i -o "ueransim-$function_name-[a-z0-9]+-[a-z0-9]+")
elif [[ $function_name == "gnbsim" ]]; then
    pod_name=$(kubectl get pods -n $namespace | egrep -i -o "$function_name-[a-z0-9]+-[a-z0-9]+")
else
    pod_name=$(kubectl get pods -n $namespace | egrep -i -o "free5gc-$function_name-[a-z0-9]+-[a-z0-9]+")
fi

if [[ -z $container_name ]]; then
    echo "Using shell $shell for pod $pod_name"
    kubectl exec -it $pod_name -n $namespace -- $shell
else
    echo "Using shell $shell for pod $pod_name container $container_name"
    kubectl exec -it $pod_name -c $container_name -n $namespace -- $shell
fi
