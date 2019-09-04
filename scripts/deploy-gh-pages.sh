#!/usr/bin/env bash
source ./scripts/initial-ci.sh

# delete all files except ./dist
# run "find . \! -name 'dist' -depth '1' -delete"
run "mv ./dist ../dist"
run "rm -rf *"

# move files in /dist folder to root folder
run "mv ../dist/* ./"
#mv ./dist/* ./

# remove /dist folder
 run "rm -rf dist"
#rm -rf dist