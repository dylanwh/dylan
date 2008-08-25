# Dylan William Hardison's .zshrc file.
# This script is executed for every interactive shell.
# See also: ~/.zshenv ~/.zprofile [~/.zshrc] ~/.zlogin ~/.zlogout

## {{{ VARIABLES
HISTSIZE=2000
SAVEHIST=2000
HISTFILE=~/.zhistory
READNULLCMD=${PAGER:-/usr/bin/pager}
LOGCHECK=30
watch=(all)
fignore=(.o .hi .pyc)
cdpath=(~ ~/src)
fpath=(~/.zsh $fpath)

## }}}
## {{{ OPTIONS
setopt autocd                  # change to dirs without cd
setopt autopushd               # automatically append dirs to the push/pop list
setopt pushdignoredups         # and don't duplicate them
setopt nocdablevars            # the need for an explicit $
setopt listpacked              # compact completion lists
setopt nolisttypes             # show types in completion
setopt extended_glob           # weird & wacky pattern matching - yay zsh!
setopt alwaystoend             # when complete from middle, move cursor
setopt completeinword          # not just at the end
setopt glob_complete           # complete globs with a menu.
setopt nocorrect               # no spelling correction
setopt promptcr                # add \n which overwrites cmds with no \n
setopt histverify              # when using ! cmds, confirm first
setopt interactivecomments     # escape commands so i can use them later
setopt printexitvalue          # alert me if something's failed
setopt hist_ignore_dups        # ignore same commands run twice+
setopt appendhistory           # don't overwrite history 
setopt nomatch                 # #fooo!
setopt noclobber               # don't overwrite files with >
setopt sharehistory            # share history between all running instances.
setopt hist_find_no_dups       # ignore dups in history search.
setopt noflow_control          # disable control-q/control-s
setopt hashcmds                # avoid having to type 'rehash' all the time.
setopt rm_star_wait            # wait beforing ask if I want to delete all those files...
setopt multios                 # avoid having to use 'tee'
setopt checkjobs               # warn me about bg processes when exiting
setopt nohup                   # and don't kill them, either
setopt auto_continue           # automatically continue disowned jobs.
setopt auto_resume             # automatically resume jobs from commands
## }}}
## {{{ KEY BINDINGS
bindkey -v

case $TERM in
	linux|screen)
		bindkey "^[[1~" beginning-of-line
		bindkey "^[[3~" delete-char
		bindkey "^[[4~" end-of-line
		bindkey "^[[5~" up-line-or-history   # PageUp
		bindkey "^[[6~" down-line-or-history # PageDown
		bindkey "^[[A"  up-line-or-search    # up arrow for back-history-search
		bindkey "^[[B"  down-line-or-search  # down arrow for fwd-history-search
		bindkey "^?"   backward-delete-char
		bindkey "^H"   backward-delete-char
	;;
	rxvt-unicode)
		bindkey "^[[5~" up-line-or-history # pgup
		bindkey "^[[6~" down-line-or-history # pgdown
		bindkey "^[[7~" beginning-of-line  # home
		bindkey "^[[8~" end-of-line        # end
		bindkey "^[[A" up-line-or-search   # up arrow
		bindkey "^[[B" down-line-or-search # down arrow
		bindkey "^?"   backward-delete-char
		bindkey "^H"   backward-delete-char
	;;
	*xterm*|rxvt*|(dt|k|E)term)
		bindkey "^[[2~" yank
		bindkey "^[[3~" delete-char
		bindkey "^[[5~" up-line-or-history # PageUp
		bindkey "^[[6~" down-line-or-history # PageDown
		bindkey "^[[7~" beginning-of-line
		bindkey "^[[8~" end-of-line
		bindkey "^[[A" up-line-or-search ## up arrow for back-history-search
		bindkey "^[[B" down-line-or-search ## down arrow for fwd-history-search
		bindkey " " magic-space ## do history expansion on space
	;;
esac

bindkey -a q quote-line
bindkey -a Q quote-region
bindkey -a 'H' run-help
bindkey "^_" copy-prev-shell-word
bindkey '^P' push-input
bindkey '^[h' run-help

## }}}
## {{{ FUNCTIONS 
function chpwd {
	ztitle
	have todo && todo --timeout --summary 
}
function mdc { mkdr -p $1 && cd $1 }
function shuffle {
	RANDOM=`date +%s`
	(
	while IFS= read -r i; do
	    echo $RANDOM$RANDOM "$i";
	done
	) | sort | sed 's/^[0-9]* //'
}
function namedir {
	declare -g $1=$2
	: ~$1
}
## }}}
## {{{ ALIASES
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias md="mkdir -p"
alias rd="rmdir"
alias df="df -h"
alias free="free -m"
alias grep='egrep --color=auto'
alias ggrep='command grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias ls='ls --color=auto -F -h'
alias la='ls -ax'
alias ll='ls -l'
alias lsd='ls -d *(/)'
alias vi=vim
alias gvi=gvim
alias vimrc="$EDITOR ~/.vimrc"
alias muttrc="$EDITOR ~/.mutt/muttrc"
alias zrc='vim ~/.zshrc'
alias zenv='vim ~/.zshenv' 
alias xrc='vim ~/.xinitrc'
alias xmrc='vim ~/.xmonad/xmonad.hs'
alias xs=cd
alias zreload='exec $SHELL'
alias help=run-help
alias pdoc=perldoc
alias g="sr google"
alias pd=popd
alias pu=pushd
alias find="noglob find"
alias menu="vim ~/.menu"
## }}}

# Autoload various functions
unalias run-help
autoload sshbegin sshend run-help ztitle
autoload compinit promptinit taskinit

# initialize advanced tab completion.
compinit -d ~/.zcompdump

# Add sbin directories for sudo's tab completion.
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
	/usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

promptinit           # Setup prompt theming 
prompt dylan         # Set the prompt.

taskinit

umask  022           # Create files that are read-only by group.
stty -ixon           # Disable the freeze-the-terminal-on-control-s thing.
mesg   yes           # Allow messages
ttyctl -f            # Freeze terminal properties.

have pinfo && alias info=pinfo

for dircolors in dircolors gdircolors; do
	if have $dircolors; then
		unset LS_COLORS
		eval $($dircolors ~/.dir_colors)
		# Colorize completions.
		zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
		break
	fi
done

if have gls; then
	alias ls="gls --color=auto -Fh"
fi

namedir taskdir ~/task/today

ztitle
have todo && todo --timeout --summary

case $HOST in
	odin*)
		setopt nosharehistory
	;;
	mani*)
		cdpath=($cdpath ~/src/r-stream)
esac

# vim: set sw=4 ts=4 foldmethod=marker path=.,~/.zsh:
