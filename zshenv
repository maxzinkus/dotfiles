alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

function vim-plug() {
    if [ -n $1 -a -n $2 ]
    then cd ~/.vim/pack ; git submodule add "$2" "plugins/start/$1" ;
       git add .gitmodules "plugins/start/$1" ;
       git commit -m "Add plugin $1"
    else echo "usage: vim-plug <name> <git remote>"
    fi
    cd - >/dev/null
}

function vim-plug-update() {
    cd ~/.vim/pack
    git submodule update --remote --merge
    git commit -am "Updating plugins"
    cd - >/dev/null
}

function vim-plug-remove() {
    if [ -n $1 ]
    then cd ~/.vim/pack ; git submodule deinit "plugins/start/$1"
        git rm "plugins/start/$1"
        rm -rf ".git/modules/plugins/start/$1"
        git commit -m "Delete plugin $1"
    else echo "usage: vim-plug-remove <name>"
    fi
    cd - >/dev/null
}

function upgrade_oh_my_zsh () {
    env ZSH=$ZSH sh $ZSH/tools/upgrade.sh
}
