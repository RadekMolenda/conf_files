#!/bin/bash
main(){
  source $HOME/.bashrc
  CODE=$HOME/Code/247

  # start the aggregation app
  cd_to_app_and_execute 'aggregation' "AGG f" "bundle exec foreman start"

  start_app "business_rules" "B_RULES"

  sleep 4

  start_app 'www' "www"

  start_app "core" "CORE"

  cd_to_app_and_execute 'admin' "ADMIN" "../../unicorns/unicorn_otb_admin_app start && tail -f -n30 log/development.log"

  start_app "middleware" "MIDD"

  cd_to_app_and_execute 'middleware' "midd_worker" "bundle exec foreman start"

  start_app "livebook" "LB"

  cd_to_app_and_execute 'admin' "admin_worker" "bundle exec foreman start"

  start_app "geolocation" "GEO"

  start_app "hotels" "HO"

  y_s 'p_Slog' "tail -f -n30 /var/log/otbeach.log"

  y_s "p_s" "cd $CODE/otb_perl_search/current; bundle exec foreman start"

  start_app "customer_messaging" "CS_m"

  start_app "reviews" "REVIEWS"

  start_app "partners" "PARTNERS"

  start_app "customer_myb" "CMYB"

  start_app "dealfinder" "dealfinder"

  # restart nginx and apache

  sleep 2

  restart_servers

  y_s "/" "cd $HOME"

  exit 0
}
cd_to_app_and_execute(){
  y_s "$2" "cd $CODE/otb_$1_app/current; $3"
  cd $HOME
}
start_app() {
  cd_to_app_and_execute "$1" "$2" "eval 'bundle exec unicorn -c config/unicorn.rb &' && tail -f log/development.log"
}
restart_service() {
  sudo service $1 restart
}

main
