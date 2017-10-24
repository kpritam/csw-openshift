#!/bin/bash

down.sh
minishift stop
minishift start --vm-driver=virtualbox