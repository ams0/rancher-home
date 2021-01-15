#!/bin/bash

rke remove --force
ansible "rke" -m script -a playbooks/scripts/docker_prune.sh


