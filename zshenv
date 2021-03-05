skip_global_compinit=1

export EDITOR="vim"

alias pbcopy='kitty +kitten clipboard'

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
    git submodule update --remote --merge &&
    git commit -am "Updating plugins"
    popd >/dev/null
}

function vim-plug-remove() {
    if [ $ARGC -eq 1 ] && [ -d ~/.vim/pack/plugins/start/"$1" ] && [ -n "$1" ]
    then if read -q "TEMP?Remove plugin $1? [y/N] "
        then pushd ~/.vim/pack >/dev/null
            git submodule deinit "plugins/start/$1" ;
            git rm "plugins/start/$1" ;
            rm -rf ".git/modules/plugins/start/$1" ;
            git commit -m "Delete plugin $1" ;
        fi
        popd >/dev/null
    else echo "usage: vim-plug-remove <name>" ; return 1
    fi
}

function omz-update {
    local ZSH="/home/user/.oh-my-zsh"
    local ZSH_CACHE_DIR="$ZSH/cache"
    env ZSH="$ZSH" sh "$ZSH/tools/upgrade.sh"
    # Update last updated file
    zmodload zsh/datetime
    echo "LAST_EPOCH=$(( EPOCHSECONDS / 60 / 60 / 24 ))" >! "${ZSH_CACHE_DIR}/.zsh-update"
    # Remove update lock if it exists
    command rm -rf "$ZSH/log/update.lock"
}
