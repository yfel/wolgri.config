# .zshrc
#{{{ ZSH stuff
hosts=(`hostname` router mybook imagery )

#{{{ URXVT workaround - stop first line completion bug in tiling WMs
if test "$TERM" = "rxvt-unicode"; then
    sleep 0.1 && clear
fi
#}}}

#{{{ History
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
#}}}

#{{{ Autoload
autoload -U compinit
compinit
autoload -U zcalc   # Math          
zstyle :compinstall filename '/home/duke/.zshrc'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
#}}}

#{{{ other opts
setopt NO_BG_NICE # don't nice background tasks
setopt nobeep 
# Use hard limits, except for a smaller stack and no core dumps
unlimit
limit stack 8192
limit core 0
limit -s
# Set/unset  shell options
setopt   notify globdots correct pushdtohome cdablevars autolist
setopt   correctall autocd recexact longlistjobs
setopt   autoresume histignoredups pushdsilent noclobber
setopt   autopushd pushdminus extendedglob rcquotes mailwarning
unsetopt bgnice autoparamslash

umask 022

#}}}

#{{{ Completion
# :completion:::::
# Expansion options
zstyle ':completion:*' completer _complete _prefix
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:predict:*' completer _complete

# Expand partial paths
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-slashes 'yes'

# Separate matches into groups
zstyle ':completion:*:matches' group 'yes'

# Describe each match group.
zstyle ':completion:*:descriptions' format "%B---- %d%b"

# Messages/warnings format
zstyle ':completion:*:messages' format '%B%U---- %d%u%b' 
zstyle ':completion:*:warnings' format '%B%U---- no match for: %d%u%b'
 
# Describe options in full
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'

zstyle ':completion:*:*:*:*' menu yes select
zstyle ':completion:*:*:*' force-list always
zstyle -d ':completion:*:*:cd:*'
zstyle -d ':completion:*:cd:*'
#}}}

#{{{ Window Title
case $TERM in
    *xterm*|rxvt|rxvt-unicode|rxvt-256color|(dt|k|E)term)
        precmd () { print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~]\a" } 
        preexec () { print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~] ($1)\a" }
    ;;
    screen)
        precmd () { 
            print -Pn "\e]83;title \"$1\"\a" 
            print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~]\a" 
        }
        preexec () { 
            print -Pn "\e]83;title \"$1\"\a" 
            print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~] ($1)\a" 
        }
    ;; 
esac
#}}}

#{{{ Prompt Config
setprompt () {
    # load some modules
    autoload -U colors zsh/terminfo # Used in the colour alias below
    colors
    setopt prompt_subst

#    PROMPT="[%{$fg_bold[cyan]%}%~%{$reset_color%}]-> "
#    PROMPT="[%{$fg[white]%}%n %{$fg_bold[cyan]%}%~%{$reset_color%}]> "
#    RPROMPT="[%{$fg_bold[yellow]%}%D{%H:%M}%{$reset_color%}]"
    PROMPT="%{$fg_bold[grey]%}[%{$fg_bold[white]%}%~%{$reset_color%}%{$fg_bold[grey]%}]%{$reset_color%}-%{$fg_bold[yellow]%}»%{$reset_color%} "
    RPROMPT="%{$fg[white]%}%D{%H:%M}%{$reset_color%}"
}

setprompt
#}}}

#{{{ Autoload zsh modules when they are referenced
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
zmodload -ap zsh/mapfile mapfile
# stat(1) is now commonly an external command, so just load zstat
zmodload -aF zsh/stat b:zstat
autoload -Uz compinit
#}}}

#{{{ Key Bindings
bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line
bindkey "\e[3~" delete-char
bindkey '^i' expand-or-complete-prefix
bindkey "\e[8~" end-of-line
bindkey "\e[7~" beginning-of-line

bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[5~" beginning-of-history
bindkey "\e[6~" end-of-history
bindkey "\e[3~" delete-char
bindkey "\e[2~" quoted-insert
bindkey "\e[5C" forward-word
bindkey "\e[5D" backward-word
bindkey "\e\e[C" forward-word
bindkey "\e\e[D" backward-word
bindkey "^H" backward-delete-word
# for rxvt
bindkey "\e[8~" end-of-line
bindkey "\e[7~" beginning-of-line
# completion in the middle of a line
bindkey '^i' expand-or-complete-prefix
#}}}

#{{{ Completion Styles

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'
    
# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# command for process lists, the local web server details and host completion
#zstyle ':completion:*:processes' command 'ps -o pid,s,nice,stime,args'
#zstyle ':completion:*:urls' local 'www' '/var/www/htdocs' 'public_html'
zstyle '*' hosts $hosts

# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
    '*?.old' '*?.pro'
# the same for old style completion
#fignore=(.o .c~ .old .pro)

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'
#}}}
#}}}

#{{{ Alias
alias lsd='ls -ld *(-/DN)'
alias -g M='|more'
alias -g H='|head'
alias -g T='|tail'
alias lsa='ls -ld .*'
alias mv='nocorrect mv'       # no spelling correction on mv
alias cp='nocorrect cp'       # no spelling correction on cp
alias mkdir='nocorrect mkdir' # no spelling correction on mkdir
alias j=jobs
alias pu=pushd
alias po=popd
alias d='dirs -v'
alias h=history
alias grep=egrep
alias ll='ls -l'
alias la='ls -a'
alias trnm=" transmission-remote mybook:9091"
alias lls='ls -ahl --color | more; echo "\e[1;32m --[\e[1;34m Dirs:\e[1;36m `ls -al | egrep \"^drw\" | wc -l` \e[1;32m|\e[1;35m Files: \e[1;31m`ls -al | egrep -v \"^drw\" | grep -v total | wc -l` \e[1;32m]--"'
alias awesome-restart='echo "awesome.restart()"|awesome-client'
alias rm="rm -i"
alias ls='ls --color'
alias dir='ls --color --format=vertical'
alias ll='ls -lha'
alias la='ls -A'
alias l='ls -CF'
alias cdd="cd .."
alias lss="ls -shaC"
alias r='fc -s'
alias o="netstat -tuael --numeric-hosts --numeric-ports"
alias lsnet="sudo lsof -i4 -P -T"
alias du="du -h"
alias df="df -h"
alias h="history 24"
alias ssu="sudo bash"
alias d='dirs -v'
alias pst='pstree -G |more'
alias toprun="ps axo %cpu,%mem,comm |sort -unr| head -n 9"
alias psaux="ps aux"
alias ps_top="ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"
alias lls='ls -ahl $1 | more; echo "\e[1;32m --[\e[1;34m Dirs:\e[1;36m `ls -al $1 | egrep \"^drw\" | wc -l` \e[1;32m|\e[1;35m Files: \e[1;31m`ls -al | egrep -v \"^drw\" | grep -v total | wc -l` \e[1;32m]--"'

alias weather="clweather -s UKKK"
#}}}

#{{{ Functions
setenv() { typeset -x "${1}${1:+=}${(@)argv[2,$#]}" }  # csh compatibility
freload() { while (( $# )); do; unfunction $1; autoload -U $1; shift; done }

#{{{ viewing man pages
function man 
{
  /usr/bin/man $* | col -bp | iconv -c | view -c 'set ft=man nomod nolist' -
}
roll () {
    FILE=$1
    case $FILE in
        *.tar.bz2) shift && tar cjf $FILE $* ;;
        *.tar.gz) shift && tar czf $FILE $* ;;
        *.tgz) shift && tar czf $FILE $* ;;
        *.zip) shift && zip $FILE $* ;;
        *.rar) shift && rar $FILE $* ;;
    esac
}
#}}}
#{{{ extract_
extract_ () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)  tar xjf $1      ;;
            *.tar.gz)   tar xzf $1      ;;
            *.bz2)      bunzip2 $1      ;;
            *.rar)      rar x $1        ;;
            *.gz)       gunzip $1       ;;
            *.tar)      tar xf $1       ;;
            *.tbz2)     tar xjf $1      ;;
            *.tgz)      tar xzf $1      ;;
            *.zip)      unzip $1        ;;
            *.Z)        uncompress $1   ;;
            *)          echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}
#}}}
#{{{ pskill
pskill () {

    if [ ! -z $1 ] ; then
        local pid
        pid=$(ps ax | grep $1 | grep -v grep | awk '{ print $1 }')
        if [ x$pid != x ] ; then
            echo -n ">> Killing $1 (process $pid)... "
            kill -9 $pid
            echo "slaughtered"
        else
            echo "!! Process not found"
        fi
    else
        echo "!! Need process name"
    fi
}
#}}}
#{{{ psgrep 
psgrep() {
    if [ ! -z $1 ] ; then
        echo "Grepping for processes matching $1..."
        ps ax | grep $1 | grep -v grep
    else
        echo "!! Need name to grep for"
    fi
}
#}}}
#{{{ search
function search()
{
 	case "$1" in
 		-g) w3m http://www.google.com/search\?q=$2
 		;;
 		-u) w3m http://groups.google.com/groups\?q=$2
 		;;
 		-m) w3m http://groups.google.com/groups\?selm=$2
 		;;
 		-a) w3m http://groups.google.com/groups\?as_uauthors=$2
 		;;
 		-c) w3m http://search.cpan.org/search\?query=$2\&mode=module
 		;;
 		-f) w3m http://freshmeat.net/search/\?q=$2\&section=projects
 		;;
 		-s) w3m "http://sourceforge.net/search/?type_of_search=soft&type_of_search=soft&words=$2"
 		;;
 		-w) w3m http://ru.wikipedia.org/wiki/$2
 		;;
 		-W) w3m http://en.wikipedia.org/wiki/$2
 		;;
 		*) 
 		  echo "Usage: $0 {-g | -u | -m | -a | -f | -c | -F | -s | -w | -W | -d}"
 		  echo "	-g:  Searching for keyword in google.com"
 		  echo "	-u:  Searching for keyword in groups.google.com"
 		  echo "	-m:  Searching for message-id in groups.google.com"
 		  echo "	-a:  Searching for Authors in groups.google.com"
 		  echo "	-c:  Searching for Modules on cpan.org."
 		  echo "	-f:  Searching for projects on Freshmeat."
 		  echo "	-F:  Searching for packages on FileWatcher."
 		  echo "	-G:  Gentoo file search."
 		  echo "	-s:  Searching for software on Sourceforge."
 		  echo "	-w:  Searching for keyword at wikipedia (german)."
 		  echo "	-W:  Searching for keyword at wikipedia (english)."
 		  echo "	-d:  Query dict.leo.org ;)"
 	esac
}
#}}}
#{{{ Roll
roll () {
    FILE=$1
    case $FILE in
        *.tar.bz2) shift && tar cjf $FILE $* ;;
        *.tar.gz) shift && tar czf $FILE $* ;;
        *.tgz) shift && tar czf $FILE $* ;;
        *.zip) shift && zip $FILE $* ;;
        *.rar) shift && rar $FILE $* ;;
    esac
}
#}}}
#}}}

#{{{ Exports 
export MPD_HOST=127.0.0.1
export NOCOLOR_PIPE
export NOCOLOR_NEXT
export LESS=-cex3M
export HELPDIR=/usr/local/lib/zsh/help  # directory for run-help function to find docs
manpath=($X11HOME/man /usr/man /usr/lang/man /usr/local/man)
export MANPATH
export MPD_PORT=6600
export OOO_FORCE_DESKTOP=gnome
export DISPLAY=":0"
export PATH=$PATH:$HOME/bin:$HOME/scripts:/usr/games
export FLASH_FORCE_PULSEAUDIO="1"
export LANG=uk_UA.UTF-8
export LC_ALL=uk_UA.UTF-8
export GTK2_RC_FILES=$HOME/.gtkrc-2.0
export EDITOR="vim"
#}}}

# vim: set fdm=marker tabstop=4 shiftwidth=4 expandtab smarttab autoindent smartindent nu:
