#!/bin/bash

set -e

name_pattern=$1

main(){
  list_servers_keys
  pick_server_key
  confirm_pushing
  push_key_to_servers
}

list_servers_keys(){
  echo 'listing server keys'
  for server in `list_servers`; do
    echo $server 
    echo `key $server`
  done
}

pick_server_key(){
  echo "pick server name key from server:"
  read server_name
  the_key=`key $server_name`
  echo "you picked: $server_name: $the_key"
}

confirm_pushing(){
  echo $the_key
  echo "About to push key to servers"
  echo "if known_host exists it won't overwrite it"
  echo `list_servers`
  echo "Are you sure? (yes/no)"
  read confirm
  if [ "$confirm" != "yes" ]; then
    exit 1
  fi
}

push_key_to_servers(){
  for server in `list_servers`; do
    if [ "`key $server`" == "" ]; then
      echo writen $server:$the_key
      ssh $server "echo '$the_key' >> ~/.ssh/known_hosts"
    fi
  done
}

list_servers() {
  cat ~/.ssh/config |
  grep ^host |
  grep -v 'localhost\|*' |
  awk '{print $2}' |
  grep "$name_pattern"
}


key(){
  ssh $1 "if [ -e ~/.ssh/known_hosts ]; then cat ~/.ssh/known_hosts; fi" |
  grep "git.onthebeach.co.uk"
}

main

