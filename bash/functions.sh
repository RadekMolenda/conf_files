new_scm() {
  set -e
  filename=$1.scm
  test_filename=$1-test.scm
  bash -c "sed 's/FILENAME/$filename/' <$HOME/.vim-templates/scm/test > $test_filename"
  bash -c "sed 's/NAME/$1/' <$HOME/.vim-templates/scm/source > $filename"
  vim $filename $test_filename
}


pipe() { while read data; do $1 $data; done }

git_root_dir() { echo /home/radek/Code/247/otb_www_app/current; }

