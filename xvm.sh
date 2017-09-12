#!/bin/bash

RVM_DIR="$HOME/.rvm"
[[ -s "$RVM_DIR/scripts/rvm" ]] && source "$RVM_DIR/scripts/rvm"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

export GVM_DIR="$HOME/.gvm"
[[ -s "$GVM/scripts/gvm" ]] && source "$GVM/scripts/gvm"
