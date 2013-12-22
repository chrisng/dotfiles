#!/bin/bash

# ==============================================================================
#
# Script used to symlink dotfiles instead of copy
#
# TODO:
#  Support copying if there is a dir
#  example: 
#     if [ -d $FILE ] ; then 
#     for FILES in $FILE ; do
#       CheckFileExists
#       if PresentOptions
#     done
#
# ==============================================================================

DATE=$(date +"%Y-%m-%d_%H:%M:%S")

function link {
  FILE=$1
  ln -s `pwd`/$FILE ~/${FILE} 
}


for FILE in `ls -1d .??* |grep -v "^.git$"` ; do
  if [[ -f ~/$FILE ]] || [[ -d ~/$FILE ]]; then
    read -p "File $FILE in your home directory: Overwrite? Backup? Skip? Exit? (o/b/s/e) " -n 1
    echo 
    if [[ $REPLY =~ ^[Oo]$ ]]; then
      rm -f ~/$FILE
      link $FILE
    elif [[ $REPLY =~ ^[Bb]$ ]]; then
      mv ~/$FILE ~/${FILE}.${DATE}
      link $FILE
    elif [[ $REPLY =~ ^[Ss]$ ]]; then
      echo "Skipping $FILE"
    else
      exit 15
    fi
  else
    link $FILE
  fi
done
