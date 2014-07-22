# DOCKER-VERSION 1.1.1
FROM ubuntu:14.04
MAINTAINER Carl Saturnino <cosaturn@gmail.com>

RUN apt-get update -q
RUN apt-get install -qy build-essential curl git mercurial bzr bzip2 wget libfreetype6 libfontconfig1

# Install git
RUN curl -k -O https://storage.googleapis.com/golang/go1.2.2.linux-amd64.tar.gz
RUN tar -xzf go1.2.2.linux-amd64.tar.gz -C /usr/local/
RUN rm go1.2.2.linux-amd64.tar.gz
ENV PATH /usr/local/go/bin:/go/bin:$PATH
ENV GOPATH /go

# we're using godep to save / restore dependancies
RUN go get -v github.com/kr/godep

# Coverage
RUN go get -v github.com/axw/gocov/gocov
RUN go get -v github.com/joshuarubin/goveralls

# https://github.com/brady-vitrano/dsgrid/blob/master/files/phantomjs/Dockerfile
RUN wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.7-linux-x86_64.tar.bz2
RUN tar -xvf phantomjs-1.9.7-linux-x86_64.tar.bz2 && rm phantomjs-1.9.7-linux-x86_64.tar.bz2
RUN mv phantomjs-1.9.7-linux-x86_64 /usr/local/phantomjs-1.9.7-linux-x86_64
RUN ln -s /usr/local/phantomjs-1.9.7-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs

# YSLOW
RUN apt-get -qy install curl unzip
RUN curl -k -O http://yslow.org/yslow-phantomjs-3.1.8.zip
RUN unzip yslow-phantomjs-3.1.8.zip -d yslow-phantomjs-3.1.8 && rm yslow-phantomjs-3.1.8.zip
RUN mv yslow-phantomjs-3.1.8 /opt/yslow-phantomjs-3.1.8
