# load custom aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# pyenv
export PYENV_ROOT="/root/.pyenv"
#command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"

export EDITOR=vim

export HISTTIMEFORMAT="%y-%m-%d %T "
export HISTCONTROL=ignoreboth:erasedups
export HISTSIZE=1000000

# The first command changes the .history file mode to append. And the second configures the history -a command to be run at each shell prompt. The -a immediately writes the current/new lines to the history file.
shopt -s histappend
export PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true

# pip bash completion start
_pip_completion()
{
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   PIP_AUTO_COMPLETE=1 $1 ) )
}
complete -o default -F _pip_completion pip
# pip bash completion end
