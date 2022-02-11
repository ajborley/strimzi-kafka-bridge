#!/bin/bash
# check to see if values have been set, otherwise provide defaults

docker login -u="${ARTIFACTORY_USERNAME}" -p="${ARTIFACTORY_PASSWORD}" "${destination_registry}"

if [[ -z $B_REGISTRY ]]; then
  echo "Warning : repository setting is missing, defaulting to hyc-qp-stable-docker-local.artifactory.swg-devops.com"
  export B_REGISTRY=hyc-qp-stable-docker-local.artifactory.swg-devops.com
fi

if [[ -z $B_PLATFORM ]]; then
  echo "Error : missing platform setting"
  exit 1
fi

if [[ -z $B_OS ]]; then
  echo "Error : missing OS setting"
  exit 1
fi

if [[ -z $B_ARCH ]]; then
  echo "Error : missing architecture setting"
  exit 1
fi

export DOCKER_REGISTRY="${B_REGISTRY}"
export DOCKER_TAG="${TAG}"
export MVN_ARGS=-DskipTests
export DOCKER_ORG=strimzi



echo "1) Building replicator for $B_PLATFORM/$B_OS/$B_ARCH"
make all