#!/bin/bash

[[ -s $HOME/azure.completion.sh ]] && source $HOME/azure.completion.sh
[[ -s /usr/bin/aws_completer ]] && complete -C '/usr/bin/aws_completer' aws
[ -f /usr/share/git-core/contrib/completion/git-prompt.sh ] && . /usr/share/git-core/contrib/completion/git-prompt.sh
[ -r /etc/bash_completion.d/git ] && . /etc/bash_completion.d/git
