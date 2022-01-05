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
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && echo 'deb https://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list
RUN apt-get purge --auto-remove nodejs
RUN curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash -
RUN sudo apt-get install -y nodejs
RUN apt-get update && apt-get clean && apt-get install -y npm yarn && rm -rf /var/lib/apt/lists/*
RUN mkdir /app
WORKDIR /app
RUN gem install bundler
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
ENV RACK_ENV production
RUN RAILS_ENV=production 
RUN NODE_ENV=production 
RUN SECRET_KEY_BASE=trololo 
RUN /bin/bash -c 'bundle exec rake assets:precompile'
RUN yarn install --ignore-engines
EXPOSE 80
CMD ["rails", "s"]
