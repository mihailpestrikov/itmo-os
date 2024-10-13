#!/bin/bash

BACKUP_DIR="$HOME"

RESTORE_DIR="$HOME/restore"

last_backup=$(ls $BACKUP_DIR | grep -E "^backup-20" | sort -n | tail -1)

echo "$last_backup"

if [[ -z "$HOME/$last_backup" ]]; then
	echo "Backup not found"
	exit 0
fi


if [[ ! -d $RESTORE_DIR ]]; then
	mkdir $RESTORE_DIR
else
	rm -r $RESTORE_DIR
	mkdir $RESTORE_DIR
fi


for file in "$HOME/$last_backup"/*; do
    filename=$(basename -- "$file")
    if [ -f "$file" ]; then
        if [[ ! "$file" =~ \.[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
            cp -- "$file" "$RESTORE_DIR/${filename}"
            echo "Restored ${filename} to $RESTORE_DIR"
        fi
    fi
done
