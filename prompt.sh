#!/bin/bash

colorize(){
	echo -en "\001\e[$1;$2m\002"
}

red=`colorize 0 31`
RED=`colorize 1 31`
green=`colorize 0 32`
GREEN=`colorize 1 32`
yellow=`colorize 0 33`
YELLOW=`colorize 1 33`
blue=`colorize 0 34`
BLUE=`colorize 1 34`
lila=`colorize 0 35`
LILA=`colorize 1 35`
cyan=`colorize 0 36`
CYAN=`colorize 1 36`
grey=`colorize 0 37`
GREY=`colorize 1 37`
NC='\001\e[0m\002'              # No Color

declare -A HOST_TO_COLOR
# define color mapping like:
# HOST_TO_COLOR[hostname]=$COLOR
HOST_TO_COLOR[localhost]=$CYAN

HOSTCOLOR=${HOST_TO_COLOR[$(hostname)]}
[[ -z $HOSTCOLOR ]] && HOSTCOLOR=$GREY

PS1='`
RET=$?
if [[ ${EUID} == 0 ]]
then echo -en ${RED}\h
else echo -en ${HOSTCOLOR}\u@\h
fi
echo -en ${BLUE} \W
echo -en " ${YELLOW}"
__git_ps1 "%s "
print_environment
if [[ $RET == 0 ]]
then echo -en ${GREEN}\342\234\223
else echo -en ${RED}\342\234\227
fi
echo -en $BLUE \$ $NC
`'
