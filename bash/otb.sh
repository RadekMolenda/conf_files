OTB_CODE_DIR=~/Code/247

if [[ ! -d $OTB_CODE_DIR ]]; then
  # Bail early as we're not on an OTB machine
  return 0;
fi

UNICORN_DIR=$OTB_CODE_DIR/unicorns
VALID_APP_NAMES=( `find $OTB_CODE_DIR -maxdepth 1 -type d -exec basename {} \; |
                    grep '^otb' | grep -v '_gem$' |
                    sed -e 's/otb_//' -e 's/_app//'` )

for appname in ${VALID_APP_NAMES[*]}; do
  alias $appname="cd "$OTB_CODE_DIR"/otb_"$appname"_app/current"
done

function set_sandbox {
  export MY_SANDBOX=$1
}

function unic {
  cd $UNICORN_DIR
}

function kick_dev_queue {
  RACK_ENV=development rake resque:work QUEUE=$1
}

# USAGE: otb (start|stop|restart) <list_of_apps>
function otb {
  command=$1
  original_path=`pwd`
  shift

  for appname in $@; do
    unic && ./unicorn_otb_"$appname"_app $command
  done
  cd $original_path
}

function otb_start_all {
  original_path=`pwd`
  unic
  for i in `ls $UNICORN_DIR`; do
    ./$i start
  done
  cd $original_path
}

function otb_version {
  server=$1
  if [[ "$server" =~ ^sandbox.* ]]; then
    server=$server.247
  else
    server=$server.247.otbeach.com
  fi
  ssh $server "cat /var/www/otb_$2_app/current/DEPLOY.yml"
}

complete -o default -W "${VALID_APP_NAMES[*]} start stop restart" otb

