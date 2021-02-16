#!/bin/bash
date
if [ -z "${1}" ]
then
  echo "$0: you need to specify environment as a 1st arg: test|prod"
  exit 1
fi
lock_file="/tmp/import-metadta-${1}.lock"
if [ -f "${lock_file}" ]
then
  echo "$0: another import-metadata \"${1}\" instance is still running, exiting"
  exit 2
fi
if [ -z "${IMPORT_DIR}" ]
then
  export IMPORT_DIR="/root/go/src/github.com/LF-Engineering/dev-analytics-import-finos-metadata"
fi
cd "${IMPORT_DIR}" || exit 3
git pull || exit 4
make || exit 5
finos_repo="`cat finos_repo_access.secret`"
if [ -z "$finos_repo" ]
then
  echo "$0: missing finos_repo_access.secret file"
  exit 6
fi
da_repo="`cat da_api_repo_access.secret`"
if [ -z "$da_repo" ]
then
  echo "$0: missing da_api_repo_access.secret file"
  exit 7
fi
function remove_clones {
  rm -rf dev-analytics-finos-metadata dev-analytics-api 1>/dev/null 2>/dev/null
}
function cleanup {
  remove_clones
  rm -rf "${lock_file}"
}
> "${lock_file}"
trap cleanup EXIT
remove_clones
git clone "${finos_repo}" || exit 8
git clone "${da_repo}" || exit 9
cp dev-analytics-finos-metadata/projects.json ./projects.json || exit 10
sed -i '1,3d' ./projects.json || exit 11
cp dev-analytics-api/app/services/lf/bootstrap/fixtures/finos/shared.yaml ./shared.yaml || exit 12
remove_clones
date
echo 'Running import-metadata'
./import-metadata ./projects.json ./shared.yaml
