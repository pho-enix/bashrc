#!/bin/bash

colorize(){
	echo -en "\e[${1}m"
}

RED=`colorize 91`
GREEN=`colorize 92`
YELLOW=`colorize 93`
BLUE=`colorize 94`
LILA=`colorize 95`
CYAN=`colorize 96`
GREY=`colorize 97`

NC=`colorize 39`		# No Color

declare -A HOST_TO_COLOR
# define color mapping like:
# HOST_TO_COLOR[hostname]=$COLOR
HOST_TO_COLOR[localhost]=$CYAN

HOSTCOLOR=${HOST_TO_COLOR[$(hostname)]}
[[ -z $HOSTCOLOR ]] && HOSTCOLOR=$CYAN

PS1='`
RET=$?
if [[ ${EUID} == 0 ]]
then echo -en \[${RED}\]\h
else echo -en \[${HOSTCOLOR}\]\u@\h
fi
echo -en \[${BLUE}\] \W
echo -en " \[${YELLOW}\]"
__git_ps1 "%s "
print_environment
if [[ $RET == 0 ]]
then echo -en \[${GREEN}\]\342\234\223
else echo -en \[${RED}\]\342\234\227
fi
echo -en \[${BLUE}\] \$ \[${NC}\]
`'
