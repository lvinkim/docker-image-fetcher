FROM ubuntu:18.04

COPY jpegsrc.v9c.tar.gz /opt/
COPY Image-ExifTool-11.13.tar.gz /opt/

RUN apt-get update && apt-get install -y \
    gcc \
    build-essential \
    ca-certificates \
    imagemagick \
    webp \
  && rm -rf /var/lib/apt/lists/* && apt-get clean

RUN apt-get update && apt-get install -y \
    golang \
  && rm -rf /var/lib/apt/lists/* && apt-get clean

RUN cd /opt && tar zxvf jpegsrc.v9c.tar.gz && cd jpeg-9c \
  && ./configure && make && make install \
  && ldconfig \
  && cd /opt && rm jpegsrc.v9c.tar.gz && rm -rf jpeg-9c

RUN cd /opt && tar zxvf Image-ExifTool-11.13.tar.gz && cd Image-ExifTool-11.13 \
  && perl Makefile.PL && make && make install \
  && cd /opt && rm Image-ExifTool-11.13.tar.gz && rm -rf Image-ExifTool-11.13

WORKDIR /opt


