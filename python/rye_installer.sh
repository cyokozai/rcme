#!/bin/bash
# Install Rye
curl -sSf https://rye-up.com/get | bash
echo 'source "$HOME/.rye/env"' >> ~/.profile
echo 'source "$HOME/.rye/env"' >> ~/.bashrc
source ~/.bashrc
rye self completion > ~/.local/share/bash-completion/completions/rye.bash
rye self update 
source ~/.bashrc
rm -f rye_installer.sh