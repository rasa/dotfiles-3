#!/bin/zsh

export DEBEMAIL=debian@trevor.joynson.io

# GPG 2.1.x SSH support
# See : http://incenp.org/notes/2015/gnupg-for-ssh-authentication.html
#export SSH_AUTH_SOCK="$HOME/.gnupg/S.gpg-agent.ssh"

# Default docker machine
#: ${DOCKER_MACHINE_NAME:="dev"}

# WHy CAn't I TYpe SHift?
alias Grep='grep'
alias Less='less'

builtin bindkey "^R" fzf-history-widget

alias -g GV='| grep -v'
alias -g GIV='| grep -iv'
alias -g GI='| grep -i'

PROJECT_ROOT=$HOME/git
CODE_ROOT=$HOME/code
BUILD_ROOT=$HOME/build
REPO_ROOTS=($PROJECT_ROOT $CODE_ROOT $BUILD_ROOT)

alias -s git='git-cdclone'
