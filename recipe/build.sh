#!/bin/bash
set -exuo pipefail

export GODEBUG="tarinsecurepath=0,zipinsecurepath=0"

echo "PKG_VERSION = ${PKG_VERSION}"

PACKAGE='github.com/argoproj/argo-cd/v2/common'


go build \
    -v \
    -ldflags "-X ${PACKAGE}.version=${PKG_VERSION}" \
    -o "${PREFIX}/bin/argocd" \
    ./cmd


# save thirdparty licenses
go-licenses save ./cmd --save_path ./thirdparty

# Clear out cache to avoid file not removable warnings
chmod -R u+w $(go env GOPATH) && rm -r $(go env GOPATH)
