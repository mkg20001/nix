#!/bin/bash

set -e

nixos-rebuild boot -v --fast --show-trace "$@" 2>&1 | grep -v evaluating
