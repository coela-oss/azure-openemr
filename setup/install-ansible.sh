#!/bin/bash
set -e

sudo apt install -y software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible ansible-core
ansible-galaxy collection install community.mysql
