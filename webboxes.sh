#!/bin/bash

set -e

filter=${1:-app}

main() {
  echo Webboxes for: $filter
  for file in $(filelist)
  do
    echo -n $(basename $file) | sed 's/.rb//'
    echo -n ": "
    grep "role :$filter, " $file | eval "sed -e 's/role :$filter[^,]*, //' -e 's/[\",]//g'"
  done
  echo
}

filelist() {
  deployment_scripts |
  strip_local
}

deployment_scripts() {
  for file in config/deploy/*
  do
    echo $file
  done
}

strip_local() {
  grep -v local
}

main
