FROM ubuntu:latest
FROM ruby:2.7.2
RUN rm /etc/localtime
RUN echo 'Etc/UTC' > /etc/timezone
RUN ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime
RUN apt-get update
RUN apt-get install -y tzdata
RUN apt-get install -y git
RUN apt-get install -y ruby
RUN apt-get install -y postgresql
RUN apt-get install -y libpq-dev
RUN apt-get install -y build-essential patch ruby-dev zlib1g-dev liblzma-dev
RUN apt-get install -y nodejs
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && echo 'deb https://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y nodejs npm yarn && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN mkdir /app
WORKDIR /app
RUN gem install bundler
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . .
ENV RACK_ENV production
RUN RAILS_ENV=production NODE_ENV=production SECRET_KEY_BASE=trololo /bin/bash -c 'bundle exec rake assets:precompile&& yarn install --check-files'
EXPOSE 80
CMD ["rackup", "config.ru", "--host", "0.0.0.0", "--port", "80"]
CMD puma -C config/puma.rb"
