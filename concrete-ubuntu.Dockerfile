FROM ubuntu:trusty

RUN apt-get update

RUN apt-get install -y \
        autoconf \
        automake \
        byacc \
        flex \
        g++ \
        gcc \
        git \
        libglib2.0-0 \
        libglib2.0-dev \
        libtool \
        m4 \
        make \
        pkg-config \
        python \
        python-dev \
        python-pip \
        unzip \
        wget

RUN pip install --upgrade --ignore-installed Twisted setuptools six

ADD . /tmp/thrift
RUN cd /tmp/thrift && \
    ./bootstrap.sh && \
    PY_PREFIX=/usr/local ./configure --prefix=/usr/local && \
    make && \
    make install && \
    cd /tmp && \
    rm -rf /tmp/thrift

RUN echo '/usr/local/lib' > /etc/ld.so.conf.d/local.conf && \
    ldconfig -v

RUN echo '/usr/local/lib64/python2.7/site-packages' > /usr/local/lib/python2.7/site-packages/local.pth
