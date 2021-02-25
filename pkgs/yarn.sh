#!/bin/bash

set -euo pipefail

if [ -e package-lock.json ]; then
  mv package-lock.json PP
fi

yarn "$@"

if [ -e PP ]; then
  mv PP package-lock.json
fi

