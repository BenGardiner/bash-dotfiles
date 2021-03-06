# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export EDITOR=vim
set -o vi

export NVM_DIR=~/.nvm
if which brew > /dev/null; then
    source $(brew --prefix nvm)/nvm.sh
fi

if [ -e ~/Applications/radare2/bin ]; then
    export PATH=~/Applications/radare2/bin:${PATH}
fi

HISTCONTROL=ignoredups:ignorespace
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

shopt -s checkwinsize
shopt -s cmdhist
if $SHELL --version | awk '{ print $4 }' | grep -q -E '^4'; then
    shopt -s globstar
fi

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

if [ -f ~/src/git-flow-completion/git-flow-completion.bash ]; then
    . ~/src/git-flow-completion/git-flow-completion.bash
fi

if [ -f ~/src/liquidprompt/liquidprompt ]; then
    . ~/src/liquidprompt/liquidprompt
fi

