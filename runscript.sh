#!/bin/bash
printf "\n*******************************************************
Ask user for path to their cluster bot file
*******************************************************\n\n"

read -p 'Enter the path to your cluster bot file: ' clusterbotfile

printf "\n*******************************************************
Setting KUBECONFIG environemt variable to cluster bot file
*******************************************************\n\n"

#echo export KUBECONFIG=home/rquinter/Downloads/cluster-bot-2019-05-31-113811.kubeconfig
echo export KUBECONFIG=clusterbotfile

#cd openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit/

printf "\n*******************************************************
Logging into cluster. Please get password from cluster bot in Slack
*******************************************************\n\n"

oc login -u kubeadmin

printf "\n*******************************************************
Attempting to clone github.com/rhcs-dashboard/ceph-dev.gitcd
*******************************************************\n\n"

git clone https://github.com/rhcs-dashboard/ceph-dev
cd ceph-dev

printf "\n*******************************************************
Attempting to clone rook into ceph-dev
*******************************************************\n\n"

#git clone https://github.com/rook/rook.git

printf "\n*******************************************************
Attempting to create ceph common
*******************************************************\n\n"

oc create -f deployment/rook/common.yaml

printf "\n*******************************************************
Attempting to create ceph operator-openshift
*******************************************************\n\n"

oc create -f deployment/rook/operator-openshift.yaml

printf "\n*******************************************************
Attempting to create ceph cluster
*******************************************************\n\n"

oc create -f deployment/rook/cluster-test-openshift-https.yaml

printf "\n*******************************************************
Getting Pods
*******************************************************\n\n"

oc get pods --all-namespaces

printf "\n*******************************************************
Creating rook-ceph project
*******************************************************\n\n"

oc project rook-ceph

printf "\n*******************************************************
Attempting to create ceph external dashboard
*******************************************************\n\n"

oc create -f deployment/rook/dashboard-external-https-openshift.yaml

printf "\n*******************************************************
Attempting to expose dashboard
*******************************************************\n\n"

#oc expose service rook-ceph-mgr-dashboard

printf "\n*******************************************************
Attempting to find External-IPs and Ports
*******************************************************\n\n"

oc get svc

printf "\n*******************************************************
Attempting to find dashboard password
*******************************************************\n\n"

printf "Dashboard Password: "
echo $(kubectl get secret rook-ceph-dashboard-password -o yaml | grep "password:" | awk '{print $2}' | base64 --decode)
