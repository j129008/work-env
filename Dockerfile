FROM ubuntu:16.04
MAINTAINER davidchang

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:jonathonf/vim && \
    apt-get update && \
    apt-get install -y vim git curl zsh python3 cscope htop autojump clang libclang-dev wget openssh-server silversearcher-ag nodejs npm git-extras git-flow exuberant-ctags cppcheck tig

# install newest tmux
RUN apt-get install -y automake build-essential pkg-config libevent-dev libncurses5-dev bison byacc && \
    git clone https://github.com/tmux/tmux.git /tmp/tmux && \
    cd /tmp/tmux && \
    git checkout master && \
    sh autogen.sh && \
    ./configure && make && \
    make install

RUN git clone https://github.com/j129008/.env /root/.env && \
    cd /root/.env && \
    ./zsh_setting.sh && \
    cp .zshrc /root && \
    cp .vimrc /root && \
    vim +PlugInstall +qall

RUN ~/.local/bin/pip3 install ipython autopep8 pandas ipdb django bs4 flake8 --user
RUN chsh -s /bin/zsh

# setting ssh-server
RUN mkdir /var/run/sshd && \
    echo 'root:dockerpassword' | chpasswd && \
    sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
RUN ln -s /usr/bin/nodejs /usr/bin/node

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

# install golang
RUN wget https://dl.google.com/go/go1.13.6.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.13.6.linux-amd64.tar.gz

RUN apt-get install -y locales && \
    locale-gen en_US.UTF-8

WORKDIR /root/
