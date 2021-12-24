ARG baseimage=ubuntu:18.04
FROM $baseimage
ARG user=karthi
ARG pythonversion=python3.7
ARG uid=1000

# installing basic softwares with root privilege
RUN apt-get update && apt-get install -y --no-install-recommends \
	build-essential \
	curl \
	git \
	g++-8 \
	htop \
	iputils-ping \
	libglib2.0-0 \
	libsm6 \	
	libxext6 \
	libxrender-dev\
	net-tools \
	openssh-client \
	$pythonversion \
	python3-pip \
	$pythonversion-dev \
	python3-setuptools \
	silversearcher-ag \
	software-properties-common \
	sudo \
	tmux \
	zsh
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata
RUN add-apt-repository ppa:neovim-ppa/stable && \
	apt-get install -y neovim && \
	rm -rf /var/lib/apt/lists/*
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 700 --slave /usr/bin/g++ g++ /usr/bin/g++-7 && \ 
	update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 800 --slave /usr/bin/g++ g++ /usr/bin/g++-8 && \
	update-alternatives --install /usr/bin/python python /usr/bin/$pythonversion 1 && \
	python -m pip install pip==21.0.1
ENV PATH="$PATH:/home/$user/.local/bin"

# add user
RUN useradd -rm -d /home/$user -s /bin/bash -g root -G sudo -u $uid $user && \
	echo "$user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER $user

# setting up zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN git clone https://github.com/zsh-users/zsh-autosuggestions /home/$user/.oh-my-zsh/custom/plugins/zsh-autosuggestions && \
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /home/$user/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
COPY ./configs/zshrc /home/$user/.zshrc

# setting up neovim env
RUN python -m pip install python-language-server pylint cmake jupyterlab && \
	sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
COPY ./configs/init.vim /home/$user/.config/nvim/init.vim
COPY ./configs/pylintrc /home/$user/.pylintrc
RUN nvim +PlugInstall +qall
RUN python /home/$user/.vim/plugged/youcompleteme/install.py
ENV MPLCONFIGDIR="/tmp/"
EXPOSE 8899

# setting up tmux
RUN git clone https://github.com/tmux-plugins/tmux-yank /home/$user/.tmux/yank
COPY ./configs/tmux.conf /home/$user/.tmux.conf
ENV TERM=xterm-256color
COPY ./configs/ide_start.sh .
RUN sudo chown -R $user /home/$user

CMD /bin/zsh
