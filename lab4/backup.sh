#!/bin/bash

SOURCE_DIR="$HOME/source"
BACKUP_DIR="$HOME"
REPORT_FILE="$HOME/backup-report"
CURRENT_DATE=$(date +"%Y-%m-%d")


if ls -d "$BACKUP_DIR"/backup-20* 1>/dev/null 2>/dev/null; then
    last_backup=$(ls $BACKUP_DIR | grep -E "^backup-20" | sort -n | tail -1)
    last_backup_date=$(basename "$last_backup" | cut -d'-' -f2)
    last_backup_week=$(date -d "$last_backup_date" +%s)
    current_week=$(date -d "$CURRENT_DATE" +%s)
    week_diff=$(( (current_week - last_backup_week) / (60*60*24*7) ))
fi

if [ -z "$last_backup" ] || [ "$week_diff" -ge 1 ]; then
    backup_dir="$BACKUP_DIR/backup-$CURRENT_DATE"
    mkdir "$backup_dir"

    cp -- "$SOURCE_DIR"/* "$backup_dir" 1>/dev/null 2>/dev/null
    copied_files=$(ls "$SOURCE_DIR")

    echo "created new backup: backup-$CURRENT_DATE"
    echo "created new backup: backup-$CURRENT_DATE" >> "$REPORT_FILE"
    echo "containing files:" >> "$REPORT_FILE"
    echo "$copied_files" >> "$REPORT_FILE"
    echo "--------------------------------" >> "$REPORT_FILE"
else
    updated_files=""
    for file in "$SOURCE_DIR"/*; do
	filename="$(basename -- "$file")"
	if [ -d "$SOURCE_DIR/$filename" ]; then
	    continue
	fi

	if [ -f "$HOME/$last_backup/$filename" ]; then
	    sourceSize=$(wc -c -- "$SOURCE_DIR/${filename}" | awk '{print $1}')
	    backupSize=$(wc -c -- "$HOME/${last_backup}/${filename}" | awk '{print $1}')
	    totalSize=$(echo "${sourceSize} - ${backupSize}" | bc)
	    if [[ $totalSize != 0 ]]; then
	        mv -- "$HOME/$last_backup/$filename" "$HOME/$last_backup/$filename.$CURRENT_DATE"
		cp -R -- "$SOURCE_DIR/$filename" "$HOME/$last_backup"
		updated_files=$(echo "${updated_files}$filename ($filename.$CURRENT_DATE)\n")
	    fi
        fi

	if [ ! -f "$HOME/$last_backup/$filename" ]; then
	    echo "$HOME/$last_backup"
	    cp -- "$SOURCE_DIR/$filename" "$last_backup"
            updated_files=$(echo "${updated_files}$filename\n")
	fi
    done

    if [[ ! -z $updated_files ]]; then
    echo "updated backup: $(basename "$last_backup")"
    echo "updated backup: $(basename "$last_backup")" >> "$REPORT_FILE"
    echo "changed files:" >> "$REPORT_FILE"
    echo -e "${updated_files::-2}" >> "$REPORT_FILE"
    echo "--------------------------------" >> "$REPORT_FILE"
    else
	echo "current version of backup is relevant"
    fi
fi

