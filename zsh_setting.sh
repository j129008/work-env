#!/bin/bash

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# install zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# install zsh theme powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
cp ./.p10k.zsh ~

# install pip3
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py --user

# copy gitconfig
cp ./.gitconfig ~

# copy tmux config
cp ./.tmux.conf ~/.tmux.conf

# copy tmux config
cp ./.tern-project ~/.tern-project

# copy vim_dict
cp ./.vim_dict ~/.vim_dict
