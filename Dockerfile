FROM ubuntu:19.10

RUN echo "deb http://download.proxmox.com/debian/pve buster pve-no-subscription" > /etc/apt/sources.list.d/pve-no-subscription.list
ADD proxmox-ve-release-6.x.gpg /etc/apt/trusted.gpg.d/proxmox-ve-release-6.x.gpg

ARG DEBIAN_FRONTEND=noninteractive
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
	echo "root:gitpod" | chpasswd && \
	chmod +r /etc/apt/trusted.gpg.d/proxmox-ve-release-6.x.gpg && \
	apt-get update && apt-get upgrade -y && \
	apt-get install -y git nano screen patch fakeroot build-essential \
	devscripts libncurses5 libncurses5-dev libssl-dev bc flex bison libelf-dev \
	libaudit-dev libgtk2.0-dev libperl-dev libslang2-dev asciidoc xmlto \
	gnupg2 rsync lintian debhelper libdw-dev libnuma-dev sphinx-common \
	asciidoc-base automake cpio dh-python file gcc kmod libiberty-dev \
	libpve-common-perl libtool perl-modules python-minimal sed tar zlib1g-dev \
	lz4 awscli apt-utils sudo && \
	apt-get clean && apt-get autoremove
