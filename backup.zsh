#!/usr/bin/zsh

rsync --exclude "lost+found" -avz /mnt/sda1 tower:~/BACKUP_LAPTOP
