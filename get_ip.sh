grep "$1" ~/.ssh/config -A1 | tail -n1 | awk '{print $2}'
