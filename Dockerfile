FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Paris
ENV HOME="/root"
WORKDIR ${HOME}

# remove default ubuntu user
RUN userdel -r ubuntu || true

RUN apt-get update
RUN apt-get -y upgrade

# install basic dev tools
RUN apt-get install -y build-essential make curl wget git direnv less openssh-client openssh-server sudo

# install cloud dev tools

## install kubernetes control
#RUN apt-get install -y kubectl

## install HELM
#RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
#RUN chmod 700 get_helm.sh
#RUN ./get_helm.sh

## install argoCD
#RUN wget https://github.com/argoproj/argo-cd/releases/download/v2.10.4/argocd-linux-amd64
#RUN chmod +x argocd-linux-amd64
#RUN mv argocd-linux-amd64 /usr/local/bin/argocd

# install pyenv
RUN apt-get install -y libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev libncursesw5-dev \
    xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev llvm libncurses5-dev python3-openssl
RUN curl -fsSL https://pyenv.run | bash
ENV PYENV_ROOT="$HOME/.pyenv"
ENV PATH="$PYENV_ROOT/bin:$PATH"
RUN pyenv install 3.9
RUN pyenv install 3.10
RUN pyenv install 3.11
# 3.12 comes with 24.04

# install pipx & cli tools
#RUN apt-get install -y pipx
#ENV PATH "/root/.local/bin:$PATH"
#RUN pipx install copier
#RUN pipx install hatch
#RUN pipx install poetry
#RUN pipx install pre-commit
#RUN pipx install ruff
#RUN pipx install tox
#RUN pipx install wheel

# modify file system for other users
RUN chmod 777 /root/
RUN chmod -R 777 /root/.pyenv
#RUN chmod 775 /root/.local

RUN mkdir /source
COPY ./.bash_aliases /source/
COPY ./.bashrc /source/
COPY ./entrypoint.sh /source/
RUN chmod 666 /source/
RUN chmod +x /source/entrypoint.sh

RUN mkdir -p /var/run/sshd
EXPOSE 22
#EXPOSE 8000
ENTRYPOINT [ "/source/entrypoint.sh"]
