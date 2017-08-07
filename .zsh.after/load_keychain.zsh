#!/usr/bin/env zsh

command -v keychain > /dev/null 2>&1
if [ $? -eq 0 ] ; then
  #eval `keychain --eval --agents ssh --eval id_rsa` #id_ed25519
fi
