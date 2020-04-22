set -x REALNAME "Dylan William Hardison"
set -x EMAIL "dylan@hardison.net"
set -x MANPAGER 'less -s'
set -x LANG en_US.UTF-8
set -x LC_COLLATE POSIX # sort in POSIX order.
set -x TZ US/Eastern
set -x GOPATH $HOME/go

if [ -x /usr/libexec/path_helper ]
    source (/usr/libexec/path_helper -c | psub)
end
set -U fish_user_paths $fish_user_paths

set -l config_version (stat -c %Y ~/.config/fish/functions/apply-fish-defaults.fish)

test -z "$dylan_config_version"
or test "$config_version" -gt "$dylan_config_version"
and apply-fish-defaults

set -U dylan_config_version $config_version


if status --is-interactive
    switch "$TERM_PROGRAM"
        case vscode
            set code code
            if string match -q "*insider" $TERM_PROGRAM_VERSION
                abbr -a -g -- code code-insiders
                set code code-insiders
            end
            set -x EDITOR "$code -w"
            abbr -a -g -- vi $code
            abbr -a -g -- vim $code
        case '*'
            set -x ALTERNATE_EDITOR ""
            set -x EDITOR "emacsclient -t"
            abbr -a -g vi emacs
    end

    for env_file in plenv pyenv chef brew
        test -f ~/.config/fish/{$env_file}.fish
        and source ~/.config/fish/{$env_file}.fish
    end

    set -U BASE16_SHELL "$HOME/.config/base16-shell"
    if test -d $BASE16_SHELL
        function base16-load
            source $BASE16_SHELL/profile_helper.fish
        end
        # load currently active theme...
    end

    if test -e ~/.base16_theme
        set -l SCRIPT_NAME (basename (realpath ~/.base16_theme) .sh)
        set -gx BASE16_THEME (string match 'base16-*' $BASE16_THEME  | string sub -s (string length 'base16-*'))
        eval sh '"'(realpath ~/.base16_theme)'"'
    end

    test -f {$HOME}/.iterm2_shell_integration.fish
    and source {$HOME}/.iterm2_shell_integration.fish
end

