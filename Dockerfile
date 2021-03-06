FROM ubuntu:21.04

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get upgrade -y && \
	apt-get install sudo wget htop vim bash-completion asciidoctor -y && \
	wget -O /etc/apt/trusted.gpg.d/proxmox-ve-release-6.x.gpg http://download.proxmox.com/debian/proxmox-ve-release-6.x.gpg && \
	echo "deb http://download.proxmox.com/debian/pve buster pve-no-subscription" > /etc/apt/sources.list.d/pve-no-subscription.list && \
	useradd -l -u 33333 -G sudo -md /home/gitpod -s /bin/bash -p gitpod gitpod && \
	echo "PS1='\[\e]0;\u \w\a\]\[\033[01;32m\]\u\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\] \\\$ '" >> /home/gitpod/.bashrc && \
	useradd -l -u 33334 -G sudo -md /home/builder -s /bin/bash -p builder builder && \
	echo "PS1='\[\e]0;\u \w\a\]\[\033[01;32m\]\u\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\] \\\$ '" >> /home/builder/.bashrc && \
	sed -i.bkp -e 's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers && \
	echo "root:passwd" | chpasswd && \
	echo "builder:passwd" | chpasswd && \
	echo "gitpod:passwd" | chpasswd && \
	chmod +r /etc/apt/trusted.gpg.d/proxmox-ve-release-6.x.gpg && \
	apt-get update && apt-get upgrade -y && \
	apt-get install -qy git nano screen patch fakeroot build-essential \
	devscripts libncurses5 libncurses5-dev libssl-dev bc flex bison libelf-dev \
	libaudit-dev libgtk2.0-dev libperl-dev libslang2-dev asciidoc xmlto \
	gnupg2 rsync lintian debhelper libdw-dev libnuma-dev sphinx-common \
	asciidoc-base automake cpio dh-python file gcc kmod libiberty-dev \
	libpve-common-perl libtool perl-modules python-minimal sed tar zlib1g-dev \
	lz4 awscli apt-utils dwarves&& \
	apt-get clean && apt-get autoremove && \
	rm -rf /var/lib/apt/lists/* /tmp/*

USER builder
RUN sudo echo "Running 'sudo' for builder: success"
USER gitpod
RUN sudo echo "Running 'sudo' for gitpod: success"
