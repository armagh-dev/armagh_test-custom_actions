#!/bin/bash
set -e
set -x

cp /jenkins/.hgrc .
cp -r /jenkins/.gem .

cd /workspace
gem install bundler --no-doc
bundle install

ruby --version
mongod --version

rake ci_vm

BRANCH=$(hg branch)

if [ "$BRANCH" == "default" ]
then
  rake prerelease
fi


