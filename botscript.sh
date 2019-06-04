#!/bin/bash

tempdir=$(mktemp -d)
cd $tempdir

printf "\n*******************************************************
Checking for existence of oc and kubectl
*******************************************************\n\n"

if [ -e /usr/bin/oc  ] && [ -e /usr/bin/kubectl ]
then
   printf "oc and kubectl are installed in the bin"
else
 printf "\n*******************************************************
 Installing oc and kubectl and copying to /usr/bin
 *******************************************************\n\n"
 sudo curl -LS -o h.tar.gz https://github.com/openshift/origin/releases/download/v3.11.0/openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz
 sudo tar -xzvf h.tar.gz -C ./
 ocdir=$(ls | grep openshift-origin-client-tools-v3.11.0-*******-linux-64bit | head -1)
 cd $ocdir
 sudo cp oc /usr/bin
 sudo cp kubectl /usr/bin
fi

#printf "\n*******************************************************
#Ask user for path to their cluster bot file
#*******************************************************\n\n"

#read -p 'Enter the path to your cluster bot file: ' clusterbotfile

#printf "\n*******************************************************
#Setting KUBECONFIG environemt variable to cluster bot file
#*******************************************************\n\n"

#echo export KUBECONFIG=home/rquinter/Downloads/cluster-bot-2019-05-31-141019.kubeconfig
#echo export KUBECONFIG=clusterbotfile

#cd openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit/

printf "\n*************************************************************************************************
Logging into cluster. Please make sure config file for current cluster is downloaded.
The Cluster-Bot will have provided the password.
***********************************************************************************************************\n\n"

me=$(logname)
configfile=$(ls /home/$me/Downloads | grep cluster-bot-*-*-*-*.* | tail -1)
if ! grep -q cluster-bot-*-*-*-*.* <<< $configfile ; then
  echo "Failed to find value kubeconfig file. Have you donwloaded it from the cluster bot?"
  exit 1
fi
echo "export KUBECONFIG=home/$me/Downloads/$configfile"
servername=$(grep server: /home/$me/Downloads/$configfile | cut -c 13-83)
oc login $servername

printf "\n*******************************************************
Attempting to clone github.com/rhcs-dashboard/ceph-dev.gitcd (if necessary)
*******************************************************\n\n"

git clone https://github.com/rafaelquint/ceph-dev.git
cd ceph-dev

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
Waiting for Dashboard External-IP and Port to be revealed
*******************************************************\n\n"

#sleep 25
#oc get svc

svcoutput=$(oc get svc)
i=0

until grep -q ' *-*.us-east-1.elb.amazonaws.com' <<< $svcoutput; do
  if [ $i -gt 180 ] ; then
    printf "\n"
    echo "ERROR: Timed out waiting for dashboard ip to be exposed. Running this script again may fix it."
    break
  fi
  printf "."
  #echo $svcoutput
  #printf "\n\n****\n\n"
  #temp=$(grep ' *-*.us-east-1.elb.amazonaws.com' <<< $svcoutput)
  #echo $temp
  i=$[$i+1]
  sleep 1
  svcoutput=$(oc get svc)
done

if [ $i -lt 180 ]; then
  printf "\n"
  ips=$(oc get svc | grep ' *-*.us-east-1.elb.amazonaws.com' | tr -s [:blank:] | cut -d " " -f 4 | head -1)
  port=$(oc get svc | grep ' *-*.us-east-1.elb.amazonaws.com' | tr -s [:blank:] | cut -d " " -f 5 |  cut -d ":" -f 1 | head -1)
  printf "\n"
  echo "Dashboard link: https://$ips:$port"
  echo "NOTE: This link may not be responsive immediately. You may have to wait a few minutes for it to work."
fi

printf "\n*******************************************************
Waiting for dashboard password to be revealed
*******************************************************\n\n"
#sleep 30

perr=$( kubectl get secret rook-ceph-dashboard-password -o yaml 2>&1 > /dev/null)

j=0
while grep -q 'Error' <<< $perr; do
  if [ $j -gt 180 ] ; then
    printf "\n"
    echo "ERROR: Timed out waiting for dashboard password to be exposed. Running this script again may fix it."
    break
  fi
  printf "."
  #echo $password
  j=$[$j+1]
  sleep 1
  perr=$(kubectl get secret rook-ceph-dashboard-password -o yaml 2>&1 > /dev/null)
done

if [ $j -lt 180 ]; then
  printf "\n"
  echo "Dashboard User Name: admin"
  printf "Dashboard Password: "
  echo $(kubectl get secret rook-ceph-dashboard-password -o yaml | grep "password:" | awk '{print $2}' | base64 --decode)
fi
