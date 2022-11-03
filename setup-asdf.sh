#!/bin/bash

set -xeuo pipefail

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
