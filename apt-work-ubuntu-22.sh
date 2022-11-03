#!/bin/bash

# docker server and cli tools
sudo apt install -y ca-certificates curl gnupg lsb-release docker-compose
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo usermod -aG docker "${USER}"
newgrp docker

# mysql server
sudo apt install -y mysql-server mysql-client-8.0 libmysqlclient-dev
sudo mysql -u root mysql -e "update user set plugin = 'mysql_native_password' where User = 'root';"

# redis server
sudo apt install -y redis-server redis-tools

# other misc (ts = timestamp output)
sudo apt install -y moreutils
