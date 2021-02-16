#!/bin/bash
if [ -z "${IMPORT_DIR}" ]
then
  export IMPORT_DIR="/root/go/src/github.com/LF-Engineering/dev-analytics-import-finos-metadata"
fi
cd "${IMPORT_DIR}" || exit 1
./import-metadata.sh local
