#!/bin/bash

start_foreman(){
  cd $1 && bundle exec foreman start > tmp/foreman_session 2>&1 &
  echo $! > tmp/foreman_pid
}

main() {
  restart_nginx
  otb start business_rules geolocation

  start_foreman ~/Code/247/otb_aggregation_app/current
  start_foreman ~/Code/247/otb_perl_search/current
  start_foreman ~/Code/247/otb_baskets_app/current
}

main
