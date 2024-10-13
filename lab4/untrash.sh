#!/bin/bash

TRASH_LOG="$HOME/.trash/.trash.log"
TMP_LOG="$HOME/.trash/.tmp.log"

if [[ $# -ne 1 ]];
then
    echo "Expected 1 argument."
    exit 1
fi


TRASH_LOG="$HOME/.trash/.trash.log"

if [ ! -f "$TRASH_LOG" ]; then
    echo "Trash.log does not exist."
    exit 1
fi

FILE="$1"

MATCHES=$(grep -F -- "$FILE" "$TRASH_LOG")

if [ -z "$MATCHES" ]; then
    echo "No matching files found in trash.log."
    exit 1
fi

echo "Found the following files in trash.log:"
echo "$MATCHES"
echo "$MATCHES" | while IFS= read -r line; do
    IFS="#" read -r source_path trash_path <<< "$line"
    filename=$(basename -- "$source_path")

    echo "Do you want to restore this file? (y/n)"
    echo "$filename"

    read -r CONFIRM < /dev/tty

    if [ "$CONFIRM" == "y" ]; then
        if [ ! -f "$trash_path" ]; then
            echo "File '$trash_path' not found in trash directory."
            continue
        fi

        restore_dir=$(dirname -- "$source_path")

	if [ ! -d "$restore_dir" ]; then
            restore_dir="$HOME"
            echo "Restoring file '$filename' to home directory."
        fi

        restore_path="$restore_dir/$filename"

        while ! ln -- "$trash_path" "$restore_path"; do
            echo "Could not restore file '$filename'. Please enter a new name:"
            read -r new_filename
            restore_path="$restore_dir/$new_filename"
        done

        echo "File '$filename' successfully restored to '$restore_path'."

        rm -- "$trash_path"

	id=$(awk -F'>>' '{print $NF}' <<< "$trash_path")
	grep -v "$id" $TRASH_LOG > $TMP_LOG ; mv $TMP_LOG $TRASH_LOG
    fi
done






