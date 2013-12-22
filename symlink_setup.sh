#!/bin/bash

# Script used to symlink dotfiles instead of copy
function link {
  FILE=$1
  ln -s `pwd`/$FILE ~/${FILE} 
}


for FILE in `ls -1d .??* |grep -v "^.git$"` ; do
  if [ -f ~/$FILE ] ; then
    read -p "This will overwrite $FILE in your home directory. Are you sure? (y/n) " -n 1
    echo 
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      rm -f ~/$FILE
      link $FILE
    fi
  else
    link $FILE
  fi
done
