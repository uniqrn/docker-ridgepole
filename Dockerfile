FROM ruby:latest
LABEL maintainer "unicorn research Ltd"

COPY gemrc /root/.gemrc
COPY Gemfile /tmp/Gemfile
WORKDIR /tmp

RUN gem update --system
RUN bundle install
ENV BUNDLE_GEMFILE /tmp/Gemfile
