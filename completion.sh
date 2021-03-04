#!/bin/bash

install_completion(){
	BINPATH=$(which $1 2> /dev/null)
	if [[ $? -eq 0 ]] ; then
		complete -C $BINPATH $1
	fi
}

source_completion(){
	COMPLETION="$1"
	[ -r $COMPLETION ] && . $COMPLETION
}

for GIT_COMPLETION in "/usr/share/git-core/contrib/completion/git-prompt.sh" "/etc/bash_completion.d/git" "/usr/local/etc/bash_completion.d/git-prompt.sh" "/usr/local/etc/bash_completion.d/git-completion.bash" "/etc/bash_completion.d/git-prompt" ; do
	source_completion $GIT_COMPLETION
done

which kubectl &> /dev/null && source <(kubectl completion bash)
which helm &> /dev/null && source <(helm completion bash)

install_completion aws_completer
install_completion vault

complete -C '/usr/local/bin/aws_completer' aws
