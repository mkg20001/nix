#!/bin/bash

set -e

nixos-rebuild switch -v --fast 2>&1 | grep -v evaluating
