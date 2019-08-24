FROM python:3.7-slim

LABEL author="Marcos Schroh" author-email="schrohm@gmail.com"
ENV DEBIAN_FRONTEND=noninteractive \
    DEBIAN_FRONTEND=teletype

RUN echo 'deb [check-valid-until=no] http://archive.debian.org/debian jessie-backports main' >> /etc/apt/sources.list
RUN apt-get update \
    && apt-get install -y --no-install-recommends apt-utils \
    && apt-get install git gcc make g++ libgflags-dev libsnappy-dev zlib1g-dev libbz2-dev liblz4-dev libzstd-dev -y \
    && apt-get autoremove -y && apt-get clean

WORKDIR /tmp/rocksdb

RUN git clone https://github.com/facebook/rocksdb.git /tmp/rocksdb \
    && make install-shared INSTALL_PATH=/usr \
    && rm -rf /tmp/rocksdb

RUN yes Y | apt-get remove --purge git libgflags-dev libsnappy-dev zlib1g-dev libbz2-dev liblz4-dev libzstd-dev