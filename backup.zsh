#!/usr/bin/zsh

if ! ssh -q tower -o RemoteCommand="exit" -o ConnectTimeout="1" >/dev/null 2>&1
then echo "Can't backup, no route to backup host." 1>&2 ; exit 1
fi

rsync --exclude "lost+found" -avz /mnt/sda1 tower:~/BACKUP_LAPTOP
