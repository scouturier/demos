#!/bin/bash

source prepare
source $demo_magic_dir/demo-magic.sh

clear

# Put your stuff here
pe "oc login <URL> --token=<TOKEN>"
pe "oc new-project minisummit"
pe "oc new-app https://github.com/openshift/nodejs-ex.git"
pe "oc expose svc/nodejs-ex"
pe "oc status"
