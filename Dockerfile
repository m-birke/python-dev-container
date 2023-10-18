FROM ubuntu:latest

RUN apt-get upgrade 
RUN apt-get update

RUN apt-get install build-essential curl git less
RUN apt-get install python3.10 python3-pip
# pyenv deps
RUN apt-get install libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
#RUN apt-get install 
RUN curl https://pyenv.run | bash
RUN pyenv install 3.7 3.8 3.9 3.10 3.11 3.12


# create & set user etc. steal from daphne
# create home dir for user
# COPY files into container home

RUN python3.10 -m pip install pipx

#
