FROM ruby:latest
LABEL maintainer "unicorn research Ltd"

RUN apt-get update && apt-get install -y --no-install-recommends libjemalloc1 \
    && rm -rf /var/lib/apt/lists/*
ENV LD_PRELOAD /usr/lib/x86_64-linux-gnu/libjemalloc.so.1

COPY gemrc /root/.gemrc
COPY Gemfile /tmp/Gemfile
WORKDIR /tmp

RUN gem update --system
RUN bundle install
ENV BUNDLE_GEMFILE /tmp/Gemfile
