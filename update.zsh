#!/usr/bin/zsh

sudo apt update ; sudo apt full-upgrade ; sudo apt autoremove ; sudo apt autoclean
sudo apt autoremove ; sudo apt autoclean
upgrade_oh_my_zsh
cd ~/.fzf ; git pull ; ./install --key-bindings --no-completion --no-bash --no-fish --no-update-rc ; cd -
vim-plug-update
pushd
cd ~/.oh-my-zsh/custom/plugins
for plugin in $(ls)
do if [ "$plugin" != "example" ]
    then cd "$plugin" ; echo "Updating $plugin" ; git pull ; cd ..
    fi
done
popd
