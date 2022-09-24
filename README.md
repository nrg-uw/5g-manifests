# About
This repository contains Kubernetes manifest files to run a 5G network consisting of 5G core network using the [Free5GC](https://github.com/free5gc/free5gc) project and RAN using the [UERANSIM](https://github.com/aligungr/UERANSIM) project.

# Installation
1. You need to have a working kubernetes cluster. Instructions for setting up a multi-node Kubernetes cluster is available in the [official docs](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/). Note that we are using `kubeadm=1.23.6-00 kubectl=1.23.6-00 kubelet=1.23.6-00` as this is the last version that supports Docker as a container runtime out of the box. If you are using the latest Kubernetes with docker, see instructions [here](https://kubernetes.io/docs/setup/production-environment/container-runtimes/#docker).

2. You need to install [Flannel CNI](https://github.com/flannel-io/flannel) and [Multus CNI](https://github.com/k8snetworkplumbingwg/multus-cni). Flannel is used for cluster networking. Multus CNI enables attaching multiple network interfaces to pods in Kubernetes, which is required for 5G NFs with multiple interfaces (e.g., UPF has the N3 interface towards gNB and the N4 interface towards SMF).

3. You need to create a local persistent volume for MongoDB. Free5GC uses MongoDB for storage. This can be created using the `create-free5gc-pv.yaml` script.
```
kubectl apply -f create-free5gc-pv.yaml
```
Note that you need to change the `path` and `values` according to your cluster.

4. The Multus CNI interfaces in the manifests, denoted by `k8s.v1.cni.cncf.io/networks` in the deployment files have static IPs assigned to them according to our lab setup (129.97.168.0/24 subnet). All these IPs need to be changed according your scenario. Use an IP range that you can access from all nodes of your Kubernetes cluster.

5. The Free5GC core can be installed as follows:
```
kubectl apply -f free5gc-v3.2.0 --recursive -n <namespace>
```
and uninstalled using:
```
kubectl delete -f free5gc-v3.2.0 --recursive -n <namespace>
```
6. The RAN (gNB + UE) can be installed as follows:
```
kubectl apply -f ueransim-v3.2.6 --recursive -n <namespace>
```
and uninstalled using:
```
kubectl delete -f ueransim-v3.2.6 --recursive -n <namespace>
```

# FAQs
1. The mongodb container is stuck at pending. 
   Make sure the local persistent volume is available. This can be checked using `kubectl get pv`. Note that uninstalling the manifests does not delete the persistent volume claim (pvc) for mongodb. This may cause mongodb to get stuck in pending state. In this case, delete the pvc, then delete and re-create the pv. See more about [Kubernetes persistent volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/).
2. Where are the container images hosted? And how do I update them to the latest version?
   The container images are hosted on Github container registry and can be found linked to [this repository](https://github.com/niloysh/free5gc-dockerfiles), which also contains the Dockerfiles used to build the images.
   You can use the Dockerfiles to update the images to the latest version. Please note that you will have to update the corresponding configuration files in the manifests, according to the version of Free5GC or UERANSIM being used.
3. How can I create multiple slices?
   Directories with have the term `slice` in them contain manifests for creating multiple slices. For example, `slice-x2` represents two slices.

# Status
- free5gc-v3.0.5 working with ueransim-v3.1.3
- free5gc-v3.2.0 working with ueranim-v3.2.6
- free5gc-v3.0.5-slice-x2 has issues and is currently being worked on.


# Credits
These manifest files are heavily inspired from [towards5gs-helm](https://github.com/Orange-OpenSource/towards5gs-helm) and the Docker images used are based on [free5gc-compose](https://github.com/free5gc/free5gc-compose).
   