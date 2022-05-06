FROM ubuntu:18.04

COPY . /root/spotify-ripper
COPY spotify_appkey.key /root/.spotify-ripper/

WORKDIR /root/spotify-ripper

RUN mkdir /output

RUN apt-get update && apt-get install -y \
    lame \
    build-essential \
    libffi-dev \
    python-dev \
    python-setuptools \
    wget

RUN wget https://mopidy.github.io/libspotify-archive/libspotify-12.1.51-Linux-x86_64-release.tar.gz && \
    tar xvf libspotify-12.1.51-Linux-x86_64-release.tar.gz && \
    cd libspotify-12.1.51-Linux-x86_64-release/ && \
    make install prefix=/usr/local

RUN cd /root/spotify-ripper && python setup.py install

ENTRYPOINT ["spotify-ripper"]
CMD ["--help"]
VOLUME ["/output"]
