#!/bin/bash

apt_install=sudo apt install -y --without-recommends

# docker server
$(apt_install) docker ca-certificates curl gnupg lsb-release
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo usermod -aG docker greg

# mysql server
$(apt_install) mysql-server mysql-client-8.0 libmysqlclient-dev

# redis server
$(apt_install) redis-server redis-tools
