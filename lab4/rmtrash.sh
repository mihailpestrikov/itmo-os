#!/bin/bash

if [ $# -ne 1 ]; then
	echo "expected 1 argument"
	exit 1
fi


TRASH_DIR="$HOME/.trash"
TRASH_LOG="$TRASH_DIR/.trash.log"


if [ ! -d "$TRASH_DIR" ]; then
	mkdir -p "$TRASH_DIR"
fi


FILE=$(readlink -f -- "$1")


if [ ! -f "$FILE" ]; then
	echo "file '$FILE' does not exist"
	exit 1
fi


DATE=$(date +"%Y%m%d%H%M%S")
BASENAME=$(basename -- "$FILE")
EXTENSION="${BASENAME##*.}"
FILENAME="${BASENAME%.*}"
TRASH_FILE="$TRASH_DIR/$FILENAME>>$DATE.$EXTENSION"

ln -- "$FILE" "$TRASH_FILE"

echo "$(realpath -- "$FILE")""#""$TRASH_FILE" >> "$TRASH_LOG"
echo "file '$FILE' was moved to trash: '$TRASH_FILE'"

rm -- "$FILE"
