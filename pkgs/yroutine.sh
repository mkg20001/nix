#!/bin/bash

set -euo pipefail

rm -rf node_modules package-lock.json yarn.lock
npm i --package-lock-only
mv package-lock.json PP
yarn
mv PP package-lock.json

