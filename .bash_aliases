# cmd line
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -la'
alias lla='ll -a'
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias grepc='grep --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# git
alias gits='git branch && git status'
alias gitc='git commit -m'
alias gita='git add .'
alias gitu='git add -u'
alias co='checkout'
alias br='br'
alias gitfup='git add -u && git commit -m "update" && git push'
alias smu='git up && git submodule foreach "git co master && git up && git submodule foreach \"git co master && git up\" " '
alias gitpr='git remote prune origin'
alias gitbd='git branch --merged main | grep -v "^[ *]*\(master\|development\|release*\)$" | xargs git branch -d'

# venvs
alias venv_init='python -m venv .venv && source .venv/Scripts/activate && pip install -e .'
alias cenv='python -m venv'
senv() {
    if [[ "$OSTYPE" == "msys" ]] ; then
    source "$1/Scripts/activate"
    fi

    if [[ "$OSTYPE" == "linux-gnu" ]] ; then
    source "$1/bin/activate"
    fi
}

# ssh
alias eval_ssh_agent='eval $(ssh-agent)'
alias add_ssh_keys='ssh-add ~/.ssh/github'
