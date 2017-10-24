#!/bin/bash

oc create -f seed/seed.yml
oc create -f config/config_pv.yml
oc create -f config/config_pvc.yml
oc create -f config/config.yml
