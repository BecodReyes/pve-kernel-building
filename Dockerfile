FROM ubuntu:19.10

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get upgrade -y && \
	apt-get install sudo wget -y && \
	wget -O /etc/apt/trusted.gpg.d/proxmox-ve-release-6.x.gpg http://download.proxmox.com/debian/proxmox-ve-release-6.x.gpg && \
	echo "deb http://download.proxmox.com/debian/pve buster pve-no-subscription" > /etc/apt/sources.list.d/pve-no-subscription.list && \
	sed -i.bkp -e 's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers && \
	echo "root:passwd" | chpasswd && \
	chmod +r /etc/apt/trusted.gpg.d/proxmox-ve-release-6.x.gpg && \
	apt-get update && apt-get upgrade -y && \
	apt-get install -qy git nano screen patch fakeroot build-essential \
	devscripts libncurses5 libncurses5-dev libssl-dev bc flex bison libelf-dev \
	libaudit-dev libgtk2.0-dev libperl-dev libslang2-dev asciidoc xmlto \
	gnupg2 rsync lintian debhelper libdw-dev libnuma-dev sphinx-common \
	asciidoc-base automake cpio dh-python file gcc kmod libiberty-dev \
	libpve-common-perl libtool perl-modules python-minimal sed tar zlib1g-dev \
	lz4 awscli apt-utils && \
	apt-get clean && apt-get autoremove
