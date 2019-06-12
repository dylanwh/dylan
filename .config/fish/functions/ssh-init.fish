function ssh-init
    switch (uname)
    case Linux
        source (ssh-agent -c -a $XDG_RUNTIME_DIR/ssh-agent.socket| sed 's/setenv/set -Ux/g'|psub)
        ssh-add
    case 'Darwin'
        ssh-add -K ~/.ssh/id_ed25519
        ssh-add -K ~/.ssh/id_rsa
    end
end
