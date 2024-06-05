
#!/bin/bash

set -xeuo pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

sudo apt install -y "${packages[@]}"

readarray -t packages < <(cat "packages.txt" | sed 's:\s*#.*$::g')

sudo apt install -y "${packages[@]}"
