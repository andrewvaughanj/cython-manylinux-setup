#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

DOCKER_IMAGE="vi/manylinux1"

cd $SCRIPT_DIR

wget "http://vapdevops.vi.vector.int/devops_deps/Vector_Root_CA_2.0.crt"

docker build -t $DOCKER_IMAGE .

echo "You must use \`DOCKER_IMAGE=\"${DOCKER_IMAGE}\"\` for a command prefix!"

# EOF
