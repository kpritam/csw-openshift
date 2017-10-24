#!/bin/bash

oc apply -f seed/
oc apply -f config/config_pv.yml
oc apply -f config/config_pvc.yml
oc apply -f config/config.yml
