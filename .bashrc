# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export SYSTEMD_PAGER=

. $HOME/.profile

if [[ $TERM == xterm ]]; then
    ppid="$(cat /proc/$$/stat | cut -d ' ' -f 4)"
    xterm="$(readlink /proc/$ppid/exe)"

    case $xterm in
        (*gnome*terminal*) TERM=xterm-256color ;;
    esac
    export TERM
    unset xterm
    unset ppid
fi


if which dircolors &> /dev/null; then
    eval $(dircolors ~/.config/dircolors-solarized/dircolors.ansi-dark)
fi