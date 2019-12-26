#!/bin/sh

set -euo pipefail

git show -s --format=%cI | date "+@%H:%M|%d.%m.%Y@" > $(dirname $(readlink -f $0))/rev
