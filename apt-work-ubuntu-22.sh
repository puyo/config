#!/bin/bash

# docker server
sudo apt install -y docker ca-certificates curl gnupg lsb-release docker-compose
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo usermod -aG docker greg

# mysql server
sudo apt install -y mysql-server mysql-client-8.0 libmysqlclient-dev

# redis server
sudo apt install -y redis-server redis-tools
