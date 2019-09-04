#!/usr/bin/env bash
source ./scripts/initial-ci.sh

# delete all files except /dist
 run "find . -depth 1 \! -name 'dist' -delete"

# move files in /dist folder to root folder
 run "mv ./dist/* ./"
#mv ./dist/* ./

# remove /dist folder
 run "rm -rf dist"
#rm -rf dist