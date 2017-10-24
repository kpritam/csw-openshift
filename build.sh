#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <image_dir> [--debug]"
  exit 1
fi

IMAGE_NAME=$1

if [ "$2" == "--debug" ]; then
  # If we're debugging, we can push code that's not committed.
  APPEND="-debug"
else
  IMAGE_PATH=/$IMAGE_NAME/

  if git status . --porcelain | grep $IMAGE_PATH > /dev/null; then
    echo "You have uncommited changes to your Docker image. Please commit them"
    echo "before building and populating. This helps ensure that all docker images"
    echo "are traceable back to a git commit."
    echo
    echo "Or if you're just building a debug image, use the --debug flag."
    exit 1
  fi
fi

# Set image tag.
GIT_REV=$(git log -n 1 --pretty=format:%h -- ./$IMAGE_NAME/)

if [ ! $GIT_REV ]; then
  echo "You're trying to build an image that has never been committed." \
    "You need to commit at least one version."
  exit 1
fi

TAG="$GIT_REV""$APPEND"

# Set image repo.
DOCKER_REPO="phkadam2008/csw-cluster-seed"

# Full image name.
IMAGE_SPEC="$DOCKER_REPO/$IMAGE_NAME:$TAG"

cd $IMAGE_NAME

if [ ! -f $DOCKERFILE ]; then
  echo "No such file: $IMAGE_NAME/$DOCKERFILE"
  exit 1
fi

echo $IMAGE_SPEC

docker build -t $IMAGE_SPEC .
docker push $IMAGE_SPEC

echo "Pushed $IMAGE_SPEC"
