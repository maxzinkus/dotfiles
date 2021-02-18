#!/usr/bin/zsh

if ! ssh -q tower -o RemoteCommand="exit" -o ConnectTimeout="1" >/dev/null 2>&1
then echo "Can't backup, no route to backup host." 1>&2 ; exit 1
fi

ls /mnt/sda1 | xargs -n1 -P4 -I% rsync --exclude "lost+found" -auv4 --partial --compress-level=0 /mnt/sda1/% backup:~/BACKUP_LAPTOP

ret=$?
if [ $ret -eq 0 ]
then touch ~/.last-backup-run ; exit $?
fi
exit $ret
