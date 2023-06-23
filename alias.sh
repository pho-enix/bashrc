#!/bin/bash

alias ll='ls -alF'

alias git_amend="git commit --amend --no-edit"
alias git_push="git push origin HEAD"
git_link(){
	git branch --set-upstream-to=origin/$1 $1
}

alias pwgen='pwgen -Bsync $[RANDOM%15+20] 1'

alias update='sudo apt update && sudo apt upgrade -y'

