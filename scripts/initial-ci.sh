#!/usr/bin/env bash
export LC_ALL=zh_CN.UTF-8
export LANG=zh_CN.UTF-8
export LANGUAGE=zh_CN.UTF-8

# add run function for print command
run() {
  echo "Run: $@"
  eval $@ || exit $?
}