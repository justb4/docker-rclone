#!/bin/bash

source version.sh

REPO_VERSION="${RC_VERSION}-${VERSION}"

REPO_NAME="justb4/rclone-sync:${REPO_VERSION}"

echo "Building ${REPO_VERSION}"

BUILD_DATE=$( date +"%Y-%m-%d-%H-%M-%S" )

docker build \
  --no-cache \
  --build-arg BUILD_DATE=${BUILD_DATE} \
  --build-arg VERSION=${REPO_VERSION} \
  --build-arg RC_VERSION=${RC_VERSION} \
  --tag ${REPO_NAME} \
  .

# docker push ${REPO_NAME}
