#misc aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias .b="source $HOME/.bashrc"
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias restart_apache='sudo service apache2 stop && sudo service apache2 start'
alias restart_nginx='sudo service nginx stop && sudo service nginx start'
alias touch_www='curl "http://local-otb.uk/" > /dev/null 2>&1 &'
alias restart_servers='restart_nginx && restart_apache && touch_www'
alias ack='ack --type-set haml=.haml --type-set eruby=.erb'

#rails/ruby aliases
alias be='bundle exec'

#git aliases
alias s='git status'
alias glog='pretty_git_log'
alias gl='pretty_git_log'
alias glh='pretty_git_log -1'
alias gla='pretty_git_log --all'
alias gr='pretty_git_log -30'

#otb aliases
alias otb_app='switch app'

#rspec aliases
alias spec_it='be rspec spec -rspec_helper'
alias profileme="history | awk '{print \$2}' | awk 'BEGIN{FS=\"|\"}{print \$1}' | sort | uniq -c | sort -n | tail -n 20 | sort -nr"
