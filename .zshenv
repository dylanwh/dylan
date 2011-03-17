# Dylan William Hardison's .zshenv file. #'
# .zshenv should not contain commands that produce output or require a tty.
# See also: [~/.zshenv] ~/.zprofile ~/.zshrc ~/.zlogin ~/.zlogout

declare -gxT PERL5LIB perl5lib # declare array
declare -U path perl5lib       # remove duplicates

#setopt noglobalrcs             # Do not load any config files from /etc.
#(( SHLVL > 1 )) && return 0    # Stop here if subshell.

path=(~/bin /opt/*/bin(N) $path)

# vim: set sw=4 ts=4 foldmethod=marker path=.,~/.zsh:
