#!/usr/bin/env zsh

# One script to bring them all and in the darkness update them

# Don't update if we can't get ICMP, or RTT > 1s
if ! ping -W 1 -c1 -q 1.1.1.1 >/dev/null 2>&1
then echo "Can't update, no internet connection." 1>&2 ; exit 1
fi

# Update ubuntu packages and clean up
echo -e "\e[34mapt update\e[0m"
sudo apt update ; sudo apt full-upgrade ; sudo apt autoremove --purge ; sudo apt autoclean

# Drop privs in case any of the scripts below try something cheeky
sudo -K

# flatpak apps
echo -e "\e[34mflatpak update\e[0m"
flatpak update -y

# Update oh-my-zsh (and its built-in themes and plugins)
omz-update

# Update vim plugins (using git submodules)
echo -e "\e[34mUpdating vim plugins\e[0m"
vim-plug-update

# Check for diff-so-fancy updates by comparing hashes
echo -e "\e[34mChecking diff-so-fancy for updates\e[0m"
local dsfurl="https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy"
local dsftmp=$(mktemp)
wget -q -O $dsftmp $dsfurl
if [ $(sha256sum $dsftmp | awk '{ print $1 }') != $(sha256sum ~/.local/bin/diff-so-fancy | awk '{ print $1 }') ]
then echo -e "New diff-so-fancy available" ;
     cp $dsftmp ~/.local/bin/diff-so-fancy.new ; chmod +x ~/.local/bin/diff-so-fancy.new ;
     echo -e "Saved to ~/.local/bin/diff-so-fancy.new" ;
fi
if [ -f $dsftmp ]
then rm $dsftmp
fi

# Update custom oh-my-zsh themes/plugins (sadly doesn't play nice with submodules)
pushd ~/.oh-my-zsh/custom/plugins
for plugin in $(ls)
do if [ "$plugin" != "example" ]
    then pushd "$plugin" ; echo -e "\e[34mUpdating $plugin\e[0m" ; git pull ; popd
    fi
done
popd
pushd ~/.oh-my-zsh/custom/themes
for theme in $(ls)
do if [ "$theme" != "example.zsh-theme" ]
    then pushd "$theme" ; echo -e "\e[34mUpdating $theme\e[0m" ; git pull ; popd
    fi
done
popd

touch ~/.last-update-run
