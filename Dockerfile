# Use Ubuntu latest LTS
FROM ubuntu:latest

RUN apt update \
  && apt install -y tzdata sudo curl zsh \
  && apt upgrade -y \
  && apt clean

ENV USER="kamontat"
ENV TZ="Asia/Bangkok"
ENV SHELL="/usr/bin/zsh"
ENV EDITOR="vim"
ENV USER_HOME="/home/$USER"
ENV MISE_LOG_FILE_LEVEL="trace"

## Setup startup shell
RUN chsh -s $SHELL

## Setup user with sudo configured
RUN useradd --create-home --uid 5000 --group sudo --shell $SHELL $USER \
  && echo "%$USER ALL=(ALL) NOPASSWD:ALL" >"/etc/sudoers.d/$USER-group"
USER $USER
WORKDIR $USER_HOME

RUN curl https://mise.run | sh

COPY --chown=$USER .tool-versions /home/kamontat/.tool-versions
COPY --chown=$USER .zshrc /home/kamontat/.zshrc
COPY --chown=$USER mise.toml /home/kamontat/.config/mise/config.toml

ENTRYPOINT [ "zsh" ]
