#!/bin/bash

# Usage: ./.devcontainer/upload.sh <container_version>
cd "$(dirname "$0")"/..

docker login
docker ps

CONTAINER_VERSION=$1
if [ -z "$CONTAINER_VERSION" ]; then
    echo "Usage: ./.devcontainer/upload.sh <container_version>"
    exit 1
fi


CONTAINER_ID=`docker ps -q -a --filter label=devcontainer.local_folder=$PWD --filter label=devcontainer.config_file=$PWD/.devcontainer/devcontainer.json`

if [ -z "$CONTAINER_ID" ]; then
    echo "No container found for $PWD"
    exit 1
fi

IMAGE_ID=`docker inspect --format='{{.Image}}' $CONTAINER_ID`
echo "Uploading $IMAGE_ID as $PREFIX$CONTAINER_VERSION. Container ID: $CONTAINER_ID"
PREFIX=dockerteamcore/doper:v
docker tag $IMAGE_ID $PREFIX$CONTAINER_VERSION
docker push $PREFIX$CONTAINER_VERSION
