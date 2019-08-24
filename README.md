## RocksDB docker image based on Python 3.7 Slim

Ideally to use with [Faust](https://faust.readthedocs.io/en/latest/).

In order to install `python rocksdb` on your own image you should run:

```
FROM marcosschroh/rocksdb:0.0.1

RUN echo 'deb [check-valid-until=no] http://archive.debian.org/debian jessie-backports main' >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends apt-utils \
    && apt-get install gcc make g++ libgflags-dev libsnappy-dev zlib1g-dev libbz2-dev liblz4-dev libzstd-dev -y

# install python driver via Faust:

RUN pip install faust[rocksdb]

# or Building python-rocksdb: 

RUn apt-get install python-virtualenv python-dev \
    && virtualenv venv \
    &&  source venv/bin/activate \
    && pip install git+git://github.com/twmht/python-rocksdb.git#egg=python-rocksdb

# optionally you can remove the dependencies necessary to compile:

RUN yes Y | apt-get remove --purge git libgflags-dev libsnappy-dev zlib1g-dev libbz2-dev liblz4-dev libzstd-dev
```