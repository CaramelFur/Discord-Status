#!/bin/bash

IMAGE_URL=ghcr.io/caramelfur/discord-status

# Exctract version from cargo.toml
VERSION=$(grep -m 1 version Cargo.toml | cut -d '"' -f 2)

echo "Building version $VERSION"

docker build -t $IMAGE_URL:$VERSION -t $IMAGE_URL:latest .

docker push $IMAGE_URL:$VERSION
docker push $IMAGE_URL:latest

echo "Done"