#!/usr/bin/env bash

##########################################
# Run this script with Makefile from root
# VERSION=0.17 make release
##########################################

ORG="crypdex"
SERVICE="blocknetdx"
VERSION='3.13'
ARCH="arm64v8 x86_64"

# Build and push builds for these architectures
for arch in ${ARCH}; do
  echo "=> Building BlocknetDX {arch: ${arch}}"

  docker build -f ${VERSION}/Dockerfile.${arch} -t ${ORG}/${SERVICE}:${VERSION}-${arch} ${VERSION}/.
  docker push ${ORG}/${SERVICE}:${VERSION}-${arch}
done


# Now create a manifest that points from latest to the specific architecture
rm -rf ~/.docker/manifests/*

# version
docker manifest create ${ORG}/${SERVICE}:${VERSION} ${ORG}/${SERVICE}:${VERSION}-x86_64 ${ORG}/${SERVICE}:${VERSION}-arm64v8
docker manifest push ${ORG}/${SERVICE}:${VERSION}

