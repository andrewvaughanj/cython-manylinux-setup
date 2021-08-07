#!/usr/bin/env bash

set -eu

PLAT=manylinux1_x86_64
DOCKER_IMAGE=quay.io/pypa/$PLAT

docker run --rm -e PLAT=$PLAT -v `pwd`:/io quay.io/pypa/$PLAT /io/scripts/build-wheels.sh

# EOF
