gitup() { git remote set-url origin git@github.otbeach.com:onthebeach/"$1".git ;}

otb_app_name() { echo "$1" | sed 's/\/current//' | sed 's/\/.*\/\(.*\)/\1/'; }

otb_current_app() { otb_app_name $(git_root_dir); }

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

git_current_branch() { git branch | grep '*' | cut -b3-; }

otb_comparision_url() { echo "https://github.otbeach.com/onthebeach/$(otb_current_app)/compare/${1-master}...$(git_current_branch | tr / \;)"; }

otb_compare() { google-chrome $(otb_comparision_url $1); }

#ALIASES
for path in $(otb_sources); do
  alias $(otb_alias_name $path)="cd "$path
done
