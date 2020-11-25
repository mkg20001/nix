#!/bin/sh

set -euo pipefail

bash up.sh
nix-channel --update -vv
bash pre.sh
