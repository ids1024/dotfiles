# Set up the prompt

#autoload -Uz promptinit
#promptinit
#prompt adam1

setopt histignorealldups sharehistory

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
#fpath=( $HOME/.zsh/functions $fpath ) #My addition
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'





VBOX_USB=usbfs

setopt autocd
export GOPATH=~/Devel/Code/go
export GEM_HOME=$(ruby -e 'puts Gem.user_dir')
export PATH=~/Devel/Utilities/bin:~/Devel/bin:$GEM_HOME/bin:$PATH:/opt/android-sdk/platform-tools:$GOROOT/bin:~/Devel/src/git/rpi-tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin:~/.cabal/bin:$GOPATH/bin

#export BROWSER=surf
#export LANG=en_US.UTF-8
export EDITOR=vim
export NNTPSERVER=nntp.aioe.org 

#if [[ $TERM -eq "st-256color" ]]
#then
#PROMPT="%U%n@%m%k%u %F{red}%(4~|...|)%3~%F{white} %# %f"
#else
#PROMPT="%B%n@%m%k %F{white}%(4~|...|)%3~%F{white} %# %b%f"
#fi

export PAGER=vimpager
alias less=vimpager

#alias lyvi-pianobar=lyvi -c ~/.config/lyvi/rc-pianobar
#function lyrics {
#	if music-ctl usepianod
		#then
       #                 lyvi-pianobar
		#else
			#lyvi
	#fi
#}
function manprint {
	man -t $1 | lpr
}

function mangui {
	export file=/tmp/man-$(random).ps
	man -t $1 > $file
	zathura $file
	rm $file

}
#alias cat=vimcat

setopt printexitvalue
setopt autopushd pushdsilent pushdtohome
setopt noclobber
setopt hist_allow_clobber

#alias ls='ls -F --color=auto' 
alias dmesg='dmesg -eHL'
alias cower='cower -c'
alias ls='grc ls -lha'
alias gcc='grc gcc'
alias ifconfig='grc ifconfig'
alias ping='grc ping'
alias traceroute='grc traceroute'
alias ps='grc ps'
alias dig='grc dig'
alias mount='grc mount'

alias p="pacman"
alias P="sudo pacman"
alias a="cower"
alias n="newsbeuter"
alias m="mutt"
alias x="xstart"
alias e="vim"
alias E="sudo vim"
alias l="lualatex"
alias s="du -hs"
alias d="dantalian"
alias cdrom="mpv cdda:// -cache 5000"
alias dvd="mpv dvdnav://menu --deinterlace auto"

function ds {
	#cd "$(dantalian-search $@)"
	droot=$(python -c "import dantalian.library;print(dantalian.library.open_library().root)")
	resultdir=$droot/results
	rm -rf $resultdir
	mkdir $resultdir
	dantalian find -t //results $@
	cd $resultdir
}

#cd ~ #why should I need this?

PROMPT="%T %F{red}%(4~|...|)%3~%f %# "

export KEYTIMEOUT=1
bindkey '^?' backward-delete-char #backspace after entering insert mode

function zle-line-init zle-keymap-select {
	RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
	#RPS1="${${KEYMAP/vicmd/            }/(main|viins)/-- INSERT --}"
	RPS2=$RPS1
	zle reset-prompt
}
function zle-line-finish {
	RPS1=""
	RPS2=""
	zle reset-prompt
}
RPS1="-- INSERT --"
RPS2=$RPS1

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select

#=== sysidk set-up
# (please leave '#===' lines) last updated Fri May 23 16:07:49 PDT 2014
source "/home/ian/.sysidk/sysidk.rc"
#=== end of sysidk set-up
#
#export PYTHONSTARTUP=/home/ian/Devel/src/git/python-startup/python-startup.py 

function ranger {
    tempfile='/tmp/chosendir'
    /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile"
}


#function man() {
#    env LESS_TERMCAP_mb=$'\E[01;31m' \
#    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
#    LESS_TERMCAP_me=$'\E[0m' \
#    LESS_TERMCAP_se=$'\E[0m' \
#    LESS_TERMCAP_so=$'\E[38;5;246m' \
#    LESS_TERMCAP_ue=$'\E[0m' \
#    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
#    man "$@"
#}


function mkdirlink {
        directory="$HOME/.directories/$(uuidgen)"
	mkdir "$directory"
	ln -s "$directory" "$1"
}

fpath=(~/.zsh/functions $fpath)

if [[ $TERM = st-256color ]]
then
	stty erase ^H
fi
