FROM ruby:2.5

ENV LANG C.UTF-8

EXPOSE 4567

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

# Dont throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 0

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install
