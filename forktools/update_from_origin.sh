#! /usr/bin/env bash

SCRIPT_DIR=$(dirname $0)

if ! git remote -v | grep fork_origin 2>&1 > /dev/null; then
  echo "Setting remote"
  ./${SCRIPT_DIR}/set_remote.sh
fi

set -x
git fetch fork_origin master
git merge fork_origin/master
set +x

