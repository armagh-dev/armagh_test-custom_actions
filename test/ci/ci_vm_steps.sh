#!/bin/bash
set -e
set -x

cp /jenkins/.hgrc .
cp -r /jenkins/.gem .

ruby --version
mongod --version
cd /workspace
gem install bundler --no-doc
bundle install
rake ci_vm && rake release