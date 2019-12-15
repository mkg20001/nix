#!/bin/bash

set -euo pipefail

list=""

_() {
  list="$list $*"
}

#_ aegir # this one is for all the protocol-labs projects
#_ nodemon parcel http-server # watchers, web dev, etc
_ pino-pretty  # show pretty logs
#_ npm-check-updates google-font-installer wscat json5 pkg # other
#_ ndb 0x # debugger and profiler
#_ jay-repl # better repl

rm -f package-lock.json
NPKG=$(cat package.json | jq -r 'del(.dependencies)')
echo "$NPKG" > "package.json"
npm i --package-lock-only $list
