#!/bin/bash

set -x

ANSIBLE_NOCOWS=1 ansible-playbook -vvv "${@:-base.yml}"
