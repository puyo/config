#!/bin/bash

set -xeuo pipefail

sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt install neovim
