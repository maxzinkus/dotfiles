#!/usr/bin/zsh

if ! ssh -q backup -o RemoteCommand="exit" -o ConnectTimeout="5" >/dev/null 2>&1
then echo "Can't backup, no route to backup host." 1>&2 ; exit 1
fi

BACKUP_DIR="/media/user/Backups"

#ls $BACKUP_DIR | xargs -n1 -P4 -I% rsync --exclude "lost+found" --exclude ".Trash-1000" -auv --partial --compress-level=0 "$BACKUP_DIR"/% backup:~/BACKUP_LAPTOP
rsync --progress --exclude "lost+found" --exclude ".Trash-1000" -auv --partial --compress-level=0 "$BACKUP_DIR" backup:~/BACKUP_LAPTOP

ret=$?
if [ $ret -eq 0 ]
then touch ~/.last-backup-run ; exit $?
fi
exit $ret
