[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
PATH=$PATH:$HOME/bin
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=10000
HISTFILESIZE=20000
shopt -s checkwinsize


export PERL_LOCAL_LIB_ROOT="/home/radek/perl5";
export PERL_MB_OPT="--install_base /home/radek/perl5";
export PERL_MM_OPT="INSTALL_BASE=/home/radek/perl5";
export PERL5LIB="/home/radek/perl5/lib/perl5/x86_64-linux-gnu-thread-multi:/home/radek/perl5/lib/perl5";
export PATH=/home/radek/lib/sbt/bin:/home/radek/perl5/bin:$PATH
export TERM='xterm+256color'
export OLD_RUBYGEMS='1.7.2'

export EDITOR="vim"
export CODE=$HOME/Code/247

export RUBY_HEAP_MIN_SLOTS=1000000
export RUBY_HEAP_SLOTS_INCREMENT=1000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=100000000
export RUBY_HEAP_FREE_MIN=500000

export GTEST_DIR=$HOME/lib/gtest-1.6.0
