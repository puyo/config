#!/bin/bash

set -xeuo pipefail

# no recommends or suggests kthx
sudo tee /etc/apt/apt.conf.d/99_norecommends <<'EOF'
APT::Install-Recommends "0";
APT::Install-Suggests "0";
APT::AutoRemove::RecommendsImportant "0";
APT::AutoRemove::SuggestsImportant "0";
EOF

# overrides the above if it exists
sudo rm -f /etc/apt/apt.conf.d/99synaptic
