ARG dist=ubuntu
ARG tag=20.04
FROM ${dist}:${tag}

MAINTAINER Sun Jiawei <sunjiawei@nj.ict.ac.cn>

RUN apt-get update && \
    apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends\
	    automake \
		autoconf \
		make \
		cmake \
		gcc \
		g++ \
		m4 \
		libtool \
		uuid \
		default-libmysqlclient-dev \
		libjsoncpp1 \
		libjsoncpp-dev \
		libperl-dev \
		libsensors5 \
		libsensors-config \
		snmp \
		snmpd \
		libsnmp35 \
        mongodb \
        python3-pip \
        python3-setuptools \
        python3-wheel \
        ninja-build \
        build-essential \
        flex \
        bison \
        git \
        meson \
        libsctp-dev \
        libgnutls28-dev \
        libgcrypt-dev \
        libssl-dev \
        libidn11-dev \
        libmongoc-dev \
        libbson-dev \
        libyaml-dev \
        libmicrohttpd-dev \
        libcurl4-gnutls-dev \
        libnghttp2-dev \
        libtins-dev \
        libtalloc-dev \
        curl \
		nodejs \
		npm \
        iproute2 \
        ca-certificates \
        netbase \
        pkg-config \
		net-tools \
		unzip \
		unrar \
		iptables \
        ifupdown \
        iputils-ping \
        sudo \
		vim && \
    apt-get clean
