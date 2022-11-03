#!/bin/bash

set -xeuo pipefail

# asdf elixir
sudo apt install -y autoconf fop libgl1-mesa-dev libglu1-mesa-dev libmysqlclient-dev libncurses5-dev libpng-dev libpq-dev libreadline-dev libssh-dev m4 unixodbc-dev xsltproc

# asdf erlang
sudo apt install -y autoconf build-essential fop libgl1-mesa-dev libglu1-mesa-dev libncurses-dev libncurses5-dev libpng-dev libssh-dev libwxgtk-webview3.0-gtk3-dev libwxgtk3.0-gtk3-dev libxml2-utils m4 unixodbc-dev xsltproc

# asdf ruby
sudo apt install -y autoconf bison build-essential libdb-dev libffi-dev libgdbm-dev libgdbm6 libncurses5-dev libreadline6-dev libssl-dev libyaml-dev uuid-dev zlib1g-dev

# asdf python
sudo apt install -y make build-essential libssl-dev zlib1g-dev \
  libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
  libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2 || true

source ~/.asdf/asdf.sh

asdf plugin add awscli
asdf plugin add elixir
asdf plugin add erlang
asdf plugin add golang
asdf plugin add kubectl
asdf plugin add nodejs
asdf plugin add python
asdf plugin add ruby
asdf plugin add rust
asdf plugin add yarn
asdf plugin add zig

cd ~/
ln -sf ~/projects/config/.asdfrc
ln -sf ~/projects/config/.tool-versions
asdf install
