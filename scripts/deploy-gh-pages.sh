#!/usr/bin/env bash
source ./scripts/initial-ci.sh

# delete all files except /dist
run "find . -d 1 -not -name dist -not -name README.md -delete"

# move files in /dist folder to root folder
run "mv /dist/* ./"

# remove /dist folder
run "rm -rf dist"