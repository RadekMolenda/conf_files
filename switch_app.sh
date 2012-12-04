VALID_APP_NAMES=( `find $OTB_CODE_DIR -maxdepth 1 -type d -exec basename {} \; |
                    grep '^otb' | grep -v '_gem$' |
                    sed -e 's/otb_//' -e 's/_app//'` )

switch_app(){
  cd $CODE/otb_$1_app/current
}
complete -o default -W "${VALID_APP_NAMES[*]}" switch_app
