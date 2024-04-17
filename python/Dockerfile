###################### BUILDER ######################
FROM ubuntu:latest AS builder

SHELL ["/bin/bash", "-c"]

WORKDIR /root

# Environment variables
ENV DEBIAN_FRONTEND = noninter active
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8
ENV TZ=Asia/Tokyo
ENV TZ JST-9
ENV TERM xterm
ENV DISPLAY host.docker.internal:0.0

#~~~~~~~~~~~~~~~~~~~~~~ EDIT ~~~~~~~~~~~~~~~~~~~~~~~#

COPY ./requirements.txt /root/
COPY ./rye_installer.sh /root/
COPY ./*.py /root/

RUN apt -y update && apt -y upgrade &&\
    apt -y install tzdata \
    locales \
    curl \
    inetutils-ping \
    net-tools \
    iproute2 \
    language-pack-ja-base language-pack-ja locales \
    python3.10 \
    python3-pip &&\
    pip3 install --upgrade pip &&\
    pip3 install -r requirements.txt &&\
    echo "alias python=python3.10" >> ~/.bashrc &&\
    echo "alias pip=pip3" >> ~/.bashrc &&\
    source ~/.bashrc &&\
    locale-gen ja_JP.UTF-8

#~~~~~~~~~~~~~~~~~~~~~~ EDIT ~~~~~~~~~~~~~~~~~~~~~~~#

EXPOSE 22
#ENTRYPOINT ["/server-scrypt/main"]
