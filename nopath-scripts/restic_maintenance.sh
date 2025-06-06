#!/usr/bin/env bash

exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>>~/.local/state/restic_maintenance.log 2>&1

echo "$(date -Ins) Running restic_maintenance.sh"

echo "$(date -Ins) Sourcing environment variables"
. "${HOME}/dotfiles/nopath-scripts/restic_env.sh"

echo "$(date -Ins) Pruning repository"
restic --verbose forget --keep-within-monthly=3 --group-by '' --prune

echo "$(date -Ins) Done running restic_maintenance.sh"
