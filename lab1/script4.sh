#!/bin/bash

current_directory=$(pwd)

if [[ "$current_directory" == "$HOME" ]]; then

echo "$HOME"
exit 0

else

echo "script must be launched from home directory"
exit 1

fi

