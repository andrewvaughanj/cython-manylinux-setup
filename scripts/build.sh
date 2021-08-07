#!/usr/bin/env bash

set -eu

PLAT=manylinux1_x86_64
DOCKER_IMAGE=${DOCKER_IMAGE:-quay.io/pypa/$PLAT}

docker run --rm -e PLAT=$PLAT -v `pwd`:/io $DOCKER_IMAGE /io/scripts/build-wheels.sh

# EOF
