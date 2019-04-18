#!/bin/bash

install_completion(){
	BINPATH=$(which $1 2> /dev/null)
	if [[ $? -eq 0 ]] ; then
		complete -C $BINPATH $1
	fi
}

[ -f /usr/share/git-core/contrib/completion/git-prompt.sh ] && . /usr/share/git-core/contrib/completion/git-prompt.sh
[ -r /etc/bash_completion.d/git ] && . /etc/bash_completion.d/git

source /usr/local/etc/bash_completion.d/git-prompt.sh
[ -r /usr/local/etc/bash_completion.d/git-completion.bash ] && . /usr/local/etc/bash_completion.d/git-completion.bash

which kubectl &> /dev/null && source <(kubectl completion bash)
which helm &> /dev/null && source <(helm completion bash)

install_completion aws_completer
install_completion vault
