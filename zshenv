export SHELL_SESSIONS_DISABLE=1 # disable macOS shared history -> setopt sharehistory in .zshrc instead
export TERM="xterm-256color"
export EDITOR="vim"

export HOMEBREW_NO_INSECURE_REDIRECT=1
export HOMEBREW_NO_EMOJI=1
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1

function vim-plug() {
    if [ $ARGC -eq 2 ] && [ ! -e ~/.vim/pack/plugins/start/"$1" ]
    then pushd ~/.vim/pack >/dev/null
        git submodule add "$2" "plugins/start/$1" &&
        git add .gitmodules "plugins/start/$1" &&
        git commit -m "Add plugin $1"
        popd >/dev/null
    else echo "usage: vim-plug <name> <git remote>" ; return 1
    fi
}

function vim-plug-update() {
    pushd ~/.vim/pack >/dev/null
    git submodule update --init --recursive --merge &&
    git commit -am "Updating plugins"
    popd >/dev/null
}

function vim-plug-remove() {
    if [ $ARGC -eq 1 ] && [ -d ~/.vim/pack/plugins/start/"$1" ] && [ -n "$1" ]
    then if read -q "TEMP?Remove plugin $1? [y/N] "
        then pushd ~/.vim/pack >/dev/null
            echo ""
            git submodule deinit "plugins/start/$1" ;
            git rm "plugins/start/$1" ;
            rm -rf ".git/modules/plugins/start/$1" ;
            git commit -m "Delete plugin $1" ;
        fi
        popd >/dev/null
    else echo "usage: vim-plug-remove <name>" ; return 1
    fi
}

function try_activate() {
    swd="$(pwd)"
    cwd="$swd"
    while [ "$cwd" != "$HOME" -a "$cwd" != "/" ]
    do if [ -d "venv" ]
        then source venv/bin/activate ; break
        else cd -q .. ; cwd="$(pwd)"
        fi
    done
    if [ "$cwd" = "$HOME" -o "$cwd" = "/" ]
    then if [ "$VIRTUAL_ENV" ]
        then deactivate
        fi
    fi
    cd -q "$swd"
}

. "$HOME/.cargo/env"
