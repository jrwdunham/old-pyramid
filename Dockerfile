FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive
ENV PYTHONUNBUFFERED 1
ENV PYTHONIOENCODING utf8

RUN set -ex \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        apt-transport-https \
        curl \
        git \
        software-properties-common \
        libldap2-dev \
        libsasl2-dev \
    && rm -rf /var/lib/apt/lists/*

# Install OS dependencies
RUN set -ex \
    && add-apt-repository "deb http://archive.ubuntu.com/ubuntu/ bionic multiverse" \
    && add-apt-repository "deb http://archive.ubuntu.com/ubuntu/ bionic-security universe" \
    && add-apt-repository "deb http://archive.ubuntu.com/ubuntu/ bionic-updates multiverse" \
    && add-apt-repository "ppa:jonathonf/ffmpeg-4" \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        python3.6-dev \
        libpython3-dev \
        python3-pip \
        python3.6-venv \
        python3-setuptools \
        ffmpeg \
        libavcodec-dev \
        libavcodec-extra \
        libavcodec-extra57 \
        imagemagick \
        libevent-dev \
        libjansson4 \
        libxml2-utils \
        md5deep \
        rsync \
        tree \
        uuid \
        supervisor \
        flex \
        sqlite3 \
        uwsgi \
        uwsgi-plugin-python \
        libtiff5-dev \
        libjpeg8-dev \
        zlib1g-dev \
        libmysqlcppconn-dev \
        libfreetype6-dev \
        liblcms2-dev \
        libreadline7 \
        libreadline-dev \
        libwebp-dev \
        tcl8.6-dev \
        tk8.6-dev \
        python-tk \
        libmysqlclient-dev \
        mysql-client-5.7 \
        libmagic-dev \
        tesseract-ocr \
        libssl-dev \
        autoconf \
        automake \
        libtool \
        gfortran \
        autoconf-archive \
        g++ \
    && rm -rf /var/lib/apt/lists/*

# Install foma (FST)
RUN set -ex \
    && curl -L https://bitbucket.org/mhulden/foma/downloads/foma-0.9.18.tar.gz --output foma-0.9.18.tar.gz \
    && tar -xvzf foma-0.9.18.tar.gz \
    && cd foma-0.9.18 \
    && make \
    && make install \
    && cd .. \
    && rm -r foma-0.9.18*

# Install DRUtils (for Tgrep2)
RUN set -ex \
    && curl -L http://tedlab.mit.edu/~dr/DRUtils/drutils.tgz --output drutils.tgz \
    && tar -xvzf drutils.tgz \
    && cd DRUtils \
    && sed -i '/CC = gcc -Wall -O4 -march=i486/c\CC = gcc -Wall -O4' Makefile \
    && make \
    && cd .. \
    && rm drutils.tgz
