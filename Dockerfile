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
RUN apt-get install -y build-essential make curl wget git direnv less nano openssh-client openssh-server sudo

# install python tools
## install uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
#RUN . $HOME/.local/bin/env
ENV PATH="$HOME/.local/bin:$PATH"

## install python
# 3.12 comes with 24.04
RUN uv python install 3.10 3.11 3.13

## install cli tools
RUN uv tool install copier
RUN uv tool install hatch
RUN uv tool install poetry
RUN uv tool install tox
RUN uv tool install pre-commit
RUN uv tool install ruff
RUN uv tool install wheel

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

# modify file system for guest users
RUN chmod 777 /root/
RUN chmod 775 /root/.local

RUN mkdir /source
COPY ./.bash_aliases /source/
COPY ./.bashrc /source/
COPY ./entrypoint.sh /source/
RUN chmod 666 /source/
RUN chmod +x /source/entrypoint.sh

RUN mkdir -p /var/run/sshd
EXPOSE 22
EXPOSE 8888
ENTRYPOINT [ "/source/entrypoint.sh"]
