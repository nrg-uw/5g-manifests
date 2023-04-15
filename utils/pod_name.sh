#!/usr/bin/env bash
function_name=$1

# set namespace
if [[ -z $2 ]]; then
    namespace="test"
else
    namespace=$2
fi


if [[ $function_name == "gnb" || $function_name == "ue" ]]; then
    pod_name=$(kubectl get pods -n test | egrep -i -o "ueransim-$function_name-[a-z0-9]+-[a-z0-9]+")
else
    pod_name=$(kubectl get pods -n test | egrep -i -o "free5gc-$function_name-[a-z0-9]+-[a-z0-9]+")
fi

echo -n $pod_name
