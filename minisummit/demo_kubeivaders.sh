#!/bin/bash

source prepare
source $demo_magic_dir/demo-magic.sh

clear

# Cloning KubeInvaders
export kubeinvaders_dir=$(mktemp -d)
git clone https://github.com/lucky-sideburn/KubeInvaders $kubeinvaders_dir 2> /dev/null
cd $kubeinvaers_dir

# Put your stuff here
pe "TARGET_NAMESPACE=minisummit"
pe "ROUTE_HOST=<KUBEINVADERSURL>"
pe "oc new-project kubeinvaders --display-name='KubeInvaders'"
pe "oc create sa kubeinvaders -n kubeinvaders"
pe "oc create sa kubeinvaders -n $TARGET_NAMESPACE"
pe "oc adm policy add-role-to-user edit -z kubeinvaders -n $TARGET_NAMESPACE"
TOKEN=$(oc describe secret -n $TARGET_NAMESPACE $(oc describe sa kubeinvaders -n $TARGET_NAMESPACE | grep Tokens | awk '{ print $2}') | grep 'token:'| awk '{ print $2}')
oc process -f openshift/KubeInvaders.yaml -p ROUTE_HOST=$ROUTE_HOST -p TARGET_NAMESPACE=$TARGET_NAMESPACE -p TOKEN=$TOKEN | oc create -f -
pe "oc status"