FROM ruby:latest As builder
COPY gemrc /root/.gemrc
COPY Gemfile /tmp/Gemfile
WORKDIR /tmp

#RUN gem update --system
RUN bundle install


FROM ruby:slim AS production
LABEL maintainer "unicorn research Ltd"

COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY --from=builder /root/.bundle /root/.bundle
COPY --from=builder /tmp/Gemfile.lock /tmp/Gemfile.lock
COPY Gemfile /tmp/Gemfile
WORKDIR /tmp

RUN apt-get update && apt-get install -y --no-install-recommends \
    libmariadb3 \
    libpq5 \
    libsqlite3-0 \
    && rm -rf /var/lib/apt/lists/*

ENV BUNDLE_GEMFILE /tmp/Gemfile

COPY scripts /root/scripts
