# Python Dev Container

Providing a Python devenv with all the tools a Python dev needs pre-installed.

Ubuntu based.

## Build

`docker build --tag pydev:latest .`

## Installed Tools

1. pyenv: 3.11
1. pipx: copier, hatch, poetry, pre-commit, ruff, tox

## Run

E.g.:

__Interactive:__

`docker run -it --rm --hostname py-dev -w /_work -v "$HOME/_work:/_work" -v "$HOME/.token:/.token" -v "$HOME/.ssh:/.ssh" -e TERM=screen-256color -e GID=$GID -e UID=$UID -e USER=$USER pydev bash`

__Remote Dev:__

`docker run -it -d --rm --name pydevc --hostname py-dev -w /_work -v "$HOME/_work:/_work" -v "$HOME/.token:/.token" -v "$HOME/.ssh:/.ssh" -e TERM=screen-256color -e GID=$GID -e UID=$UID -e USER=$USER pydev bash`

`docker logs pydevc`
