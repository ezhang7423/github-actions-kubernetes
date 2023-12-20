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


# IMAGE_ID="docker image list --filter 'reference=doper' --format='{{.ID}}'"

IMAGE_ID=`docker image list --filter 'reference=doper' --format='{{.ID}}'`
echo "Uploading $IMAGE_ID as $PREFIX$CONTAINER_VERSION. Container ID: $CONTAINER_ID"
# PREFIX=dockerteamcore/doper:v
PREFIX=dockerteamcore/doper:v
docker tag $IMAGE_ID $PREFIX$CONTAINER_VERSION
docker push $PREFIX$CONTAINER_VERSION
