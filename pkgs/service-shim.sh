#!/bin/bash

action="$1"
shift
name="$1"
shift

set -euo pipefail

# service <action> <name> => systemctl/journalctl

if [ -z "$name" ]; then
  case "$action"
    logs)
      journalctl -xef "$@"
      ;;
    *)
      echo "ERROR: Needs to specify a service name" >&2
      exit 1
      ;;
  esac
else
  case "$action"
    logs)
      journalctl -xefu "$name" "$@"
      ;;
    *)
      systemctl "$action" "$name" "$@"
      ;;
  esac
fi
