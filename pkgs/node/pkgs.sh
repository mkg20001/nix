#!/bin/bash

_() {
  gen_pkg "$1" "$1"
}

# some packages are commented out due to a bug that doesn't allow for 2500+ deps

# _ aegir
_ nodemon
# _ parcel
_ http-server
_ pino-pretty
_ npm-check-updates
_ google-font-installer
_ wscat
_ json5
_ pkg
_ ndb
_ 0x
_ jay-repl
_ diff-so-fancy