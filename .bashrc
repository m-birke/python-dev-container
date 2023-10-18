# load custom aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export SSL_CERT_FILE=~/ca-bundle.crt

export EDITOR=vim

export PATH=$PATH:/C/Progra~1/Git/usr/bin
export PATH=~/bin:$PATH:/c/Progra~2/Graphviz2.38/bin

export EDITOR=vim

export HISTTIMEFORMAT="%y-%m-%d %T "
export HISTCONTROL=ignoreboth:erasedups
export HISTSIZE=1000000

# The first command changes the .history file mode to append. And the second configures the history -a command to be run at each shell prompt. The -a immediately writes the current/new lines to the history file.
shopt -s histappend
export PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true

# If no SSH agent is already running, start one now.
# Re-use sockets so we never have to start more than one session.
tmppath=/tmp/$USER
mkdir -p $tmppath
chmod 700 $tmppath
export SSH_AUTH_SOCK=$tmppath/.ssh-socket
tmpfile=$tmppath/.ssh-script

ssh-add -l > /dev/null 2>&1
if [ $? = 2 ]; then
	# No ssh-agent running
	rm -rf $SSH_AUTH_SOCK
	# >| allows output redirection to over-write files if no clobber is set
	ssh-agent -a $SSH_AUTH_SOCK >| $tmpfile
	source $tmpfile
	echo $SSH_AGENT_PID >| $tmppath/.ssh-agent-pid
	rm -rf $tmpfile
	ssh-add
fi

# add keys which do not end with _rsa
ssh-add .ssh/main_key

# pip bash completion start
_pip_completion()
{
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   PIP_AUTO_COMPLETE=1 $1 ) )
}
complete -o default -F _pip_completion pip
# pip bash completion end
