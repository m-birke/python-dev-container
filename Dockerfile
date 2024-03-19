FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Paris
ENV HOME="/root"
WORKDIR ${HOME}

RUN apt-get update
RUN apt-get -y upgrade

RUN apt-get install -y build-essential curl git less openssh-client openssh-server sudo
# install HELM
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
RUN chmod 700 get_helm.sh
RUN ./get_helm.sh

# install pyenv
#RUN apt-get install -y libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
#RUN curl https://pyenv.run | bash
#ENV PYENV_ROOT="$HOME/.pyenv"
#ENV PATH "$PYENV_ROOT/bin:$PATH"
#RUN eval "$(pyenv init -)"
#RUN pyenv install 3.11
#RUN pyenv install 3.7 3.8 3.9 3.10 3.11 3.12
#RUN chmod 777 /root/.pyenv

# install pipx
RUN apt-get install -y pipx
ENV PATH "/root/.local/bin:$PATH"
RUN pipx install copier
RUN pipx install hatch
RUN pipx install poetry
RUN pipx install pre-commit
RUN pipx install ruff
RUN pipx install tox
RUN chmod 777 /root/.local

#RUN chmod 777 /root/

RUN mkdir /source
COPY ./.bash_aliases /source/
COPY ./.bashrc /source/
COPY ./entrypoint.sh /source/
RUN chmod 666 /source/
RUN chmod +x /source/entrypoint.sh

RUN mkdir -p /var/run/sshd
EXPOSE 22
EXPOSE 8000
ENTRYPOINT [ "/source/entrypoint.sh"]
