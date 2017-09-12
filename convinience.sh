#!/bin/bash

function wireshark_rmt()
{
	if [ $# -ne 2 ] ; then
		echo "$0 user@host interface"
		return 1
	fi
	user=$(echo $1 | cut -f1 -d@)
	host=$(echo $1 | cut -f2 -d@)
	wireshark -k -i <(ssh -l $user $host tcpdump -i $2 -s 0 -w -)
}

function extract()      # Handy Extract Program
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.tar.xz)    tar xJf $1	     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *.xz)        xz -d $1        ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

function json_clean() {
	cat $1 | json_verify &> /dev/null
	if [ $? -ne 0 ] ; then
		cat $1 | json_verify
	else
		cat $1 | json_reformat > $1.new
		[ -f $1.new ] && mv $1.new $1
	fi
}

function push_rpm(){
	if [ $# -ne 3 ] ; then
		echo "push_rpm file_regex user@host [install|update]"
		return 1
	fi

	case $3 in
		install)
		MODE="-i"
		;;
		update)
		MODE="-U"
		;;
		*)
		echo "push_rpm file_regex user@host [install|update]"
		return 1
		;;
	esac

	FILE=`ls -t ${1}* | head -1`

	if [ ! -f $FILE ] ; then
		echo "No file exists for regex $1"
		return 1
	fi

	echo "Using file: $FILE from `date -r $FILE`"

	DEST="/tmp/`basename $FILE`"

	scp -q $FILE $2:$DEST
	ssh -q $2 "rpm $MODE --force $DEST"

	INSTALLED=`ssh -q $2 "rpm -qa | grep ${1##*\/}"`

	echo "${3}ed $INSTALLED on $2"
}

function rpm_extract(){
	rpm2cpio $1 | cpio -id
}

alias show_pub="cat $HOME/.ssh/id_rsa.pub"
