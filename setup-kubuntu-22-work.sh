#!/bin/bash

packages=(
  libkrb5-dev # aws-adfs
  qgis        # maps!
)
sudo apt install -y "${packages[@]}"

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

# helm
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt-get install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm

# pgadmin
curl -fsS https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo gpg --dearmor -o /usr/share/keyrings/packages-pgadmin-org.gpg
sudo sh -c 'echo "deb [signed-by=/usr/share/keyrings/packages-pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'
sudo apt install pgadmin4-desktop

# OpenSSL config for GlobalProtect VPN
#
# /etc/ssl/openssl.cnf
#
# ...
#
# [openssl_init]
# # Comment this out:
# #providers = provider_sect
# ssl_conf = ssl_sect
#
# ...
#
# [system_default_sect]
# CipherString = DEFAULT:@SECLEVEL=2
#
# Add this:
# Options = UnsafeLegacyRenegotiation
