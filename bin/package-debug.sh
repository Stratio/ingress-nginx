#!/bin/bash -e

BASEDIR="$(realpath "$(dirname "$0")/..")"
GODIR_ROOT="$BASEDIR/cmd"

#### PREPARE
rm -rf "${BASEDIR}/dist"
mkdir "${BASEDIR}/dist"

if [[ -z "$1" ]]; then
	VERSION=$(cat $BASEDIR/VERSION)
else
	VERSION=$1
fi

export GOPATH="${BASEDIR}/dist"
export HOME="${BASEDIR}/go"

echo "Seting the dlv"
#CGO_ENABLED=0 go get -ldflags "-s -w -extldflags  '-static'" github.com/go-delve/delve/cmd/dlv 
#CGO_ENABLED=0 go build -buildvcs=false -gcflags "all=-N -l" -o  "${BASEDIR}/dist/dlv"
cd "$GODIR_ROOT/nginx"
echo "Building ingress-nginx nginx-ingress-controller..."
CGO_ENABLED=0 GOOS=linux /usr/local/go/bin/go build -buildvcs=false -gcflags "-N -l" -o "${BASEDIR}/dist/nginx-ingress-controller" ${GODIR_ROOT}/nginx
echo "Cleaning ingress-nginx nginx dependencies..."
#/usr/local/go/bin/go clean -modcache

cd "$GODIR_ROOT/dbg"
echo "Building ingress-nginx dbg..."
CGO_ENABLED=0 GOOS=linux /usr/local/go/bin/go build -buildvcs=false -gcflags "-N -l" -o "${BASEDIR}/dist/dbg" ${GODIR_ROOT}/dbg
echo "Cleaning ingress-nginx dbg dependencies..."
/usr/local/go/bin/go clean -modcache

cd "$GODIR_ROOT/waitshutdown"
echo "Building ingress-nginx wait-shutdown..."
CGO_ENABLED=0 GOOS=linux /usr/local/go/bin/go build -buildvcs=false -gcflags "-N -l" -o "${BASEDIR}/dist/wait-shutdown" ${GODIR_ROOT}/waitshutdown
echo "Cleaning ingress-nginx waitshutdown dependencies..."
/usr/local/go/bin/go clean -modcache
