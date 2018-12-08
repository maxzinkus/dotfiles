export EDITOR="vim"

alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

function vim-plug() {
    pushd ~/.vim/pack >/dev/null
    if [ $ARGC -eq 2 ] && [ ! -e "plugins/start/$1" ]
    then git submodule add "$2" "plugins/start/$1"
        git add .gitmodules "plugins/start/$1"
        git commit -m "Add plugin $1"
    else echo "usage: vim-plug <name> <git remote>" ; return 1
    fi
    popd >/dev/null
}

function vim-plug-update() {
    pushd ~/.vim/pack >/dev/null
    git submodule update --remote --merge
    git commit -am "Updating plugins"
    popd >/dev/null
}

function vim-plug-remove() {
    pushd ~/.vim/pack
    if [ $ARGC -eq 1 ] && [ -d "plugins/start/$1" ]
    then git submodule deinit "plugins/start/$1" ;
        git rm "plugins/start/$1" ;
        rm -rf ".git/modules/plugins/start/$1" ;
        git commit -m "Delete plugin $1" ;
    else echo "usage: vim-plug-remove <name>" ; return 1
    fi
    popd >/dev/null
}

function upgrade_oh_my_zsh () {
    env ZSH=$ZSH sh $ZSH/tools/upgrade.sh
}
