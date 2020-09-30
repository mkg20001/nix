#!/bin/bash

set -e

nixos-rebuild switch -v --fast --show-trace "$@" 2>&1 | grep -v evaluating
