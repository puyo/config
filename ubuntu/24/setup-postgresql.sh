#!/bin/bash

set -xeuo pipefail

sudo apt install -y postgresql libpq-dev
sudo -u postgres createuser -d -r -s "${USER}"
createdb "${USER}"
