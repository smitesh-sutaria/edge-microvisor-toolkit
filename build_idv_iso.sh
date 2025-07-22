#!/bin/bash

GIT_REPO=https://github.com/open-edge-platform/edge-microvisor-toolkit.git
TAG=3.0.20250718
IDV_JSON=

git clone $GIT_REPO
#git checkout $TAG

cd edge-microvisor-toolkit
git checkout $TAG
sudo ./toolkit/docs/building/prerequisites-ubuntu.sh
sudo ln -vsf /usr/lib/go-1.21/bin/go /usr/bin/go
sudo ln -vsf /usr/lib/go-1.21/bin/gofmt /usr/bin/gofmt
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
#git checkout $TAG
cd toolkit
wget https://raw.githubusercontent.com/smitesh-sutaria/edge-microvisor-toolkit/refs/heads/3.0/toolkit/imageconfigs/idv.json
mv idv.json ./imageconfigs

sudo make toolchain REBUILD_TOOLS=y VALIDATE_TOOLCHAIN_GPG=n --debug
sudo make iso -j8 REBUILD_TOOLS=y REBUILD_PACKAGES=n VALIDATE_TOOLCHAIN_GPG=n CONFIG_FILE=./imageconfigs/idv.json


