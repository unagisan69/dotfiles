#!/bin/bash
# Author: Chris White
# ssh-keygen and ssh-copy-id on server first.

NOW=$(date +"%m-%d-%Y")
FILE="sitename-$NOW.tar"
BACKUP_DIR="/home/user/backups"
WWW_DIR="/home/user/sitename.com/"
FINAL="$FILE.gz"
DB_USER=""
DB_PASS=""
DB_NAME=""
DB_FILE="sitename.$NOW.sql"

# Tar transforms for better archive structure.
# WWW_TRANSFORM='s,^home/username/www/example.org,www,'
# DB_TRANSFORM='s,^home/username/backups,database,'

# Create the archive and the MySQL dump
tar -cf $BACKUP_DIR/$FILE $WWW_DIR
mysqldump -u$DB_USER -p$DB_PASS -$DB_NAME > $BACKUP_DIR/$DB_FILE

# Append the dump to the archive, remove the dump and compress the whole archive.
tar --append --file=$BACKUP_DIR/$FILE $BACKUP_DIR/$DB_FILE
rm $BACKUP_DIR/$DB_FILE
gzip -9 $BACKUP_DIR/$FILE

# Upload to remote location with preexisting key.
rsync --progress $BACKUP_DIR/$FINAL user@host:/home/user/backups/sites/sitename/
