#! /usr/bin/env bash

SCRIPT_DIR=$(dirname $0)

remote_file=${SCRIPT_DIR}/remote
remote=$(cat ${remote_file})

echo Remote file = ${remote_file}
echo Remote      = ${remote}

set -x
git remote add fork_origin ${remote}
set +x
