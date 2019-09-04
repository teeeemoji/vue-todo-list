#!/usr/bin/env bash
source ./initial-ci.sh

# delete all files except /dist
run "rm -rf !(/dist)"

# move files in /dist folder to root folder
run "mv /dist/* ./"

# remove /dist folder
run "rm -rf dist"