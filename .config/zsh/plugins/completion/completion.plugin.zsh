#!/bin/zsh
# Maybe
setopt completeinword completealiases nolistbeep

zmodload -i zsh/complist

#
# Use caching so that commands like apt and dpkg complete are useable
#

# prep cache dir
if [[ -n $ZSH_CACHE_DIR ]]; then
    mkdir -pv $ZSH_CACHE_DIR
fi

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $ZSH_CACHE_DIR

zstyle ':compinstall' filename "$ZDOTDIR/compinstallrc"

## should this be in keybindings?
#bindkey -M menuselect '^o' accept-and-infer-next-history

# auto rehash
zstyle ':completion:*' rehash true
zstyle ':completion:*' auto-rehash true

zstyle ':completion:*' use-compctl false
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*' extra-verbose yes
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' file-sort modification
zstyle ':completion:*' ignore-parents pwd
zstyle ':completion:*' special-dirs true

zstyle ':completion:*' expand prefix suffix
#zstyle ':completion:*' match-original both
#zstyle ':completion:*' preserve-prefix '//[^/]##/'
#zstyle ':completion:*' max-errors 1

# menu if nb items > 2
zstyle ':completion:*' menu select=2
#zstyle ':completion:*' menu select=1
#zstyle ':completion:*' menu select=long

# disable named-directories autocompletion
#zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
#zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'expand'

# Adjust approx limits based upon size
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) )'


##
## Completers
##

# list of completers to use
zstyle ':completion:*' completer \
    _list \
    _expand \
    _complete \
    _ignored \
    _match \
    _correct \
    _approximate \
    _prefix

##
## matchers
##

#zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
#zstyle ':completion:*' matcher-list '' '+m:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+m:{[:lower:]}={[:upper:]} r:|[._-]=* r:|=*' '+r:|[._-/]=** r:|=** l:|=*'
#zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
#zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

## ignore case
#zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'


##
## Wider scope completion conf
##

# ignore useless commands and functions
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec)|prompt_*)'

# completion sorting
#zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# smart editor completion
zstyle ':completion:*:(nano|vim|nvim|vi|emacs|e):*' ignored-patterns '*.(wav|mp3|flac|ogg|mp4|avi|mkv|webm|iso|dmg|so|o|a|bin|exe|dll|pcap|7z|zip|tar|gz|bz2|rar|deb|pkg|gzip|pdf|mobi|epub|png|jpeg|jpg|gif)'

# Don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns \
    adm amanda apache at avahi avahi-autoipd beaglidx bin cacti canna \
    clamav daemon dbus distcache dnsmasq dovecot fax ftp games gdm \
    gkrellmd gopher hacluster haldaemon halt hsqldb ident junkbust kdm \
    ldap lp mail mailman mailnull man messagebus mldonkey mysql nagios \
    named netdump news nfsnobody nobody nscd ntp nut nx obsrun openvpn \
    operator pcap polkitd postfix postgres privoxy pulse pvm quagga radvd \
    rpc rpcuser rpm rtkit scard shutdown squid sshd statd svn sync tftp \
    usbmux uucp vcsa wwwrun xfs '_*'

# ... unless we really want to.
zstyle '*' single-ignored show

##
## Narrow scope completion conf
##

zstyle ':completion:*:*:cd:*:directory-stack' menu yes select

# Man
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true

## history
#zstyle ':completion:*:history-words' stop yes
#zstyle ':completion:*:history-words' remove-all-dups yes
#zstyle ':completion:*:history-words' list true
#zstyle ':completion:*:history-words' menu yes

# ignore multiple entries.
zstyle ':completion:*:(rm|kill|diff):*' ignore-line other
zstyle ':completion:*:rm:*' file-patterns '*:all-files'

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -o pid,%cpu,tty,cputime,cmd'

#zstyle ':completion:*:processes' command 'ps -au$USER'
#zstyle ':completion:*:*:kill:*' menu yes select
#zstyle ':completion:*:kill:*' force-list always
#zstyle ':completion:*:*:killall:*' menu yes select
#zstyle ':completion:*:killall:*' force-list always

#zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
#if [ "$OSTYPE[0,7]" = "solaris" ]
#then
#  zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm"
#else
#  zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
#fi

###generic completion with --help
#compdef _gnu_generic gcc
#compdef _gnu_generic gdb

##
## Formatting
##

#zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
#zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# defs
#zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' format ' %F{yellow}-- completing: %d --%f'
zstyle ':completion:*' auto-description ' %F{blue}-- %d --%f'

zstyle ':completion:*' prompt 'comp errors:%e>'
zstyle ':completion:*' list-prompt '%SAt %p (%l) %M matches: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p (%l)%s'

#zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'

# group matches and describe.
zstyle ':completion:*:options' auto-description '%F{blue}%d%f'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'


## init
#autoload -Uz compinit
#compinit

