gitup() { git remote set-url origin git@github.otbeach.com:onthebeach/"$1".git ;}

otb_app_name() { echo "$1" | sed 's/\/current//' | sed 's/\/.*\/\(.*\)/\1/'; }

otb_current_app() { otb_app_name $(pwd); }

otb_update_git_remote() { gitup $(otb_current_app); }

otb_sources() { 
  find ~/Code/{247,Gems} -maxdepth 3 -type d -iname '.git' |
  grep "otb_" |
  sed 's/\/.git//'
}

otb_update_all_git_remote() {
  current_dir=$(pwd)
  for app in $(otb_sources); do
    cd $app
    otb_update_git_remote
  done
  cd $current_dir
}

otb_captasks_update() {
  bundle exec cap -vT > $1
}

my_captasks() {
  f=tmp/captasks
  if [ ! -f $f ]; then
    $(otb_captasks_update $f)
  fi
  cat $f
}


otb_alias_name() { otb_app_name $1 | sed 's/.*otb_//' | sed 's/_\(gem\|app\)//'; }

otb_branch_name_for_comparision() { git branch | grep '*' | cut -b3- | tr / \;; }

otb_comparision_url() { echo "https://github.otbeach.com/onthebeach/$1/compare/$2"; }

otb_compare() { google-chrome $(otb_comparision_url $(otb_current_app) $(otb_branch_name_for_comparision)) ; }

#ALIASES
for path in $(otb_sources); do
  alias $(otb_alias_name $path)="cd "$path
done


