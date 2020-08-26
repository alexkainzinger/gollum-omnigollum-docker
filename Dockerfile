FROM ruby:alpine3.11
LABEL maintainer="alexander@kainzinger.dev"

# Mirrors in Germany
RUN echo "https://ftp.halifax.rwth-aachen.de/alpine/v3.11/main" >/etc/apk/repositories && \
    echo "https://ftp.halifax.rwth-aachen.de/alpine/v3.11/community" >>/etc/apk/repositories

ARG GOLLUM_VERSION=5.1.1

RUN apk add --no-cache build-base cmake openssl openssl-dev icu-dev icu-libs git 

RUN gem install gollum -v $GOLLUM_VERSION
RUN gem install github-markup omnigollum omniauth-github

RUN apk del build-base cmake openssl openssl-dev icu-dev

COPY config.rb /home/config.rb

WORKDIR /home
RUN mkdir wiki

ENTRYPOINT ["/usr/local/bundle/bin/gollum", "--config", "config.rb"]

# default port
EXPOSE 4567