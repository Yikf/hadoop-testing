#!/bin/bash
#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

set -o pipefail
set -e
set -x

function usage {
  echo "Usage: $(basename "${0}") [-f] <PR_NUMBER>" 2>&1
  echo '   -f  force overwrite of local branch (default: fail if exists)'
  exit 1
}

if [[ ${#} -eq 0 ]]; then
  usage
fi

FORCE=""
while getopts ":f" arg; do
  case "${arg}" in
    f)
      FORCE="--force"
      ;;
    ?)
      usage
      ;;
  esac
done
shift "$(($OPTIND -1))"

PR_NUM=$1

git fetch upstream pull/${PR_NUM}/head:PR_${PR_NUM} ${FORCE}
git checkout PR_${PR_NUM}
