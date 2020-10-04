#!/usr/bin/zsh

if ! ssh -q tower -o RemoteCommand="exit" -o ConnectTimeout="1" >/dev/null 2>&1
then echo "Can't backup, no route to backup host." 1>&2 ; exit 1
fi

rsync --progress --exclude "lost+found" -av --compress-level=0 /mnt/sda1 backup:~/BACKUP_LAPTOP && touch ~/.last-backup-run && exit 0 || exit 1
