#!/usr/bin/zsh

# One script to bring them all and in the darkness update them

# Update ubuntu packages and clean up
echo "apt update"
sudo apt update ; sudo apt full-upgrade ; sudo apt autoremove ; sudo apt autoclean

# Update oh-my-zsh (and its built-in themes and plugins)
upgrade_oh_my_zsh

# Update fzf
echo "Updating fzf"
pushd ~/.fzf ; git pull ; ./install --key-bindings --no-completion --no-bash --no-fish --no-update-rc ; popd

# Update vim plugins (using git submodules)
echo "Updating vim plugins"
vim-plug-update

# Check for diff-so-fancy updates by comparing hashes, and update if needed
echo "Updating diff-so-fancy"
local dsfurl="https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy"
local dsftmp=$(mktemp)
wget --no-verbose -O $dsftmp $dsfurl
if [ $(sha256sum $dsftmp | awk '{ print $1 }') != $(sha256sum ~/.local/bin/diff-so-fancy | awk '{ print $1 }') ]
then echo "Updating diff-so-fancy" ; cp $dsftmp ~/.local/bin/diff-so-fancy ; chmod +x ~/.local/bin/diff-so-fancy
fi
if [ -f $dsftmp ]
then rm $dsftmp
fi

# Update custom oh-my-zsh plugins (sadly doesn't play nice with submodules)
pushd ~/.oh-my-zsh/custom/plugins
for plugin in $(ls)
do if [ "$plugin" != "example" ]
    then pushd "$plugin" ; echo "Updating $plugin" ; git pull ; popd
    fi
done
popd
