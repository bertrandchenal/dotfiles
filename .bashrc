# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# [bch]



export PATH=$PATH:$HOME/bin/:/sbin:/usr/sbin/:$HOME/.local/bin
export PATH=$PATH:$HOME/.cargo/bin:$HOME/dev/go/bin

export GOPATH=$HOME/dev/go
export PAGER=less
export PS1="[\t] \u@\[\033[0;32m\]\h\[\033[00m\]:\w$ "
export PYTHONPATH=.local/lib/python2.7:$HOME/.local/lib/python2.7
export PYTHONSTARTUP=$HOME/.pythonrc
export EDITOR="emacs -nw"
export PYTEST_ADDOPTS="-s --tb=native --maxfail=1"
export C_INCLUDE_PATH=/home/bch/.local/include
export JANET_PATH=/home/bch/.local/lib/janet

shopt -s globstar

alias ls="ls --color"
alias l="ls -lh"
alias ll="ls -1"
alias lr="ls -lrth" 
alias e='emacsclient -c -a ""'
alias p2="python2"
alias p="python3"
alias o="xdg-open"
# alias pytest='python $(which pytest)'
alias grep="grep --color"
alias grepi="grep -i"
alias bgssh="ssh -MNf"
alias d='date "+%Y.%m.%d %H:%M:%S"'
alias t="/usr/bin/time -lp"
alias kc='keychain ~/.ssh/id_rsa; source $HOME/.keychain/$HOSTNAME-sh'
alias m="mplayer -lavdopts threads=4 00006.MTS" 

alias a=". .venv/bin/activate"
alias d="deactivate"
alias c='p -m venv .venv --prompt $(basename $PWD)'
alias py2ps="find . -not -path '*/\.*' -name '*.py' | xargs a2ps --line-numbers=1 -o code.ps"
alias t="pkill tmux -u $USER --signal USR1; tmux  a ||tmux"
alias cr="/home/bch/dev/crystal/bin/crystal"


# Activate autoenv & autojump
#source `which activate.sh`
#source /usr/share/autojump/autojump.sh
complete -C aws_completer aws

function search {
    find . -iname "*$1*"
}

function ack {
    ext=$1
    shift
    if [ $1 ]
    then
        find . \( ! -regex '.*/\..*' \) -type f -name "*$ext" | xargs grep -n --color $@
    else
        echo "Usage: ack suffix pattern"
    fi
}


function loop {
    delay=$1
    shift
    if [ "$1" ]
    then
        while true; do eval $@ ; sleep $delay;  done
    else
        echo "Usage: loop sleep command"
    fi
}

function .. {
    echo "$1"
    if [ "$1" ]
    then
        TIMES=$1
        TIMES=$((${#TIMES} + 1))
        for (( c=1; c<=$TIMES; c++ )); do cd .. ;  done
    else
        cd ..
    fi
}

older_than() {
  local target=$1
  shift
  if [ ! -e $target ]
  then
    return 0  # success
  fi
  local f
  for f in $*
  do
    if [ $f -nt $target ]
    then
      return 0  # success
    fi
  done
  return 1  # failure
}


# print the header (the first line of input) and then run the
# specified command on the body (the rest of the input) use it in a
# pipeline, e.g. ps | body grep somepattern
# src: http://unix.stackexchange.com/a/11859
function body {
    IFS= read -r header
    printf '%s\n' "$header"
    "$@"
}

# Kill all background jobs
function killjobs () {
    JOBS="$(jobs -p)";
    if [ -n "${JOBS}" ]; then
        kill -9 ${JOBS};
    fi
}

function iwait() {
    file=$1
    shift
    if [ "$1" ]
    then
        while inotifywait -e close_write "$file"; do ${@}; done
    else
        echo "Usage: iwait <file> <command>"
    fi
}

complete -C /home/bch/.local/bin/mc mc
complete -C /home/bch/bin/mc mc
