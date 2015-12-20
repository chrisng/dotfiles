#!/usr/bin/env zsh

FILES_TO_LOAD=(/usr/local/bin/virtualenvwrapper.sh ~/.exports)

for FILE in ${FILES_TO_LOAD[@]} ; do
  [ -f "${FILE}" ] && source $FILE
done
