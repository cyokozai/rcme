


apt -y install build-essential libbz2-dev libdb-dev
apt -y install libreadline-dev libffi-dev libgdbm-dev liblzma-dev
apt -y install libncursesw5-dev libsqlite3-dev libssl-dev
apt -y install python3.10
source ~/.bashrc
curl -sSf https://rye-up.com/get | bash
echo 'source "$HOME/.rye/env"' >> ~/.profile
echo 'source "$HOME/.rye/env"' >> ~/.bashrc
mkdir -p ~/.local/share/bash-completion/completions
rye self completion > ~/.local/share/bash-completion/completions/rye.bash
rye self update


RUN apt -y update &&\
    apt -y upgrade &&\
    rm -rf ~/.pyenv &&\
    apt -y install git \
    make \
    curl \
    inetutils-ping \ 
    tcpdump \ 
    iproute2 \
    netcat 
