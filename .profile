#!/bin/bash

# Get prefix if brew is installed.
_prefix=$(which brew > /dev/null && brew --prefix || echo '')


# Exports.
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export EDITOR=emacs
export TERM=xterm-256color
export CLICOLOR=true


# Bash colors.
export color_none='\e[0m'
export color_white='\e[1;37m'
export color_black='\e[0;30m'
export color_blue='\e[0;34m'
export color_light_blue='\e[1;34m'
export color_green='\e[0;32m'
export color_light_green='\e[1;32m'
export color_cyan='\e[0;36m'
export color_light_cyan='\e[1;36m'
export color_red="\e[0;31m"
export color_light_red='\e[1;31m'
export color_purple='\e[0;35m'
export color_light_purple='\e[1;35m'
export color_brown='\e[0;33m'
export color_yellow='\e[1;33m'
export color_gray='\e[0;90m'
export color_light_gray='\e[0;37m'


# SSH alias to fix TERM problem.
function ssh() {
  local old=$TERM

  TERM=xterm-color `which ssh` $@
  TERM=$old
}


# Date piece.
DATE_PIECE="\[${color_gray}\]\$(date '+%a %H:%M:%S')\[${color_none}\]"

# Git piece.
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PIECE='$(__git_ps1 " \[$color_yellow\](%s)\[$color_none\]")'

# Bash prompt.
export PS1="${DATE_PIECE} \u\[${color_green}\]@\[${color_none}\]\h \[${color_gray}\]\w${GIT_PIECE:-""}\n\[${color_green}\]\$\[${color_none}\] "

# Bash completion.
test -f "${_prefix}/etc/bash_completion" && . "${_prefix}/etc/bash_completion"

# Bash alias.
test -f ~/.bash_aliases && . ~/.bash_aliases

# Load all extensions.
for f in ~/.ext/*; do test -f "$f" && . "$f"; done

# No ._ files when copying files.
export COPYFILE_DISABLE=true
export COPY_EXTENDED_ATTRIBUTES_DISABLED=true


# Fortune, Cowsay, & Lolcat.
if which fortune > /dev/null && which cowsay > /dev/null && which lolcat > /dev/null; then
  _f() {
    o='bdgpstwy'
    c=( $(ls "${_prefix}/share/cows") )
    w=$((`tput cols` - 10))

    fortune -s | cowsay -${o:$(($RANDOM % ${#o})):1} -f${c[$(($RANDOM % ${#c}))]} -W$w | lolcat
  }

  _f
  unset _f
fi


# Unset unused variables.
unset _prefix
