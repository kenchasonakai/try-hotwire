FROM ruby:3.1.0
ENV LANG C.UTF-8
ENV TZ Asia/Tokyo
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - \
&& wget --quiet -O - /tmp/pubkey.gpg https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
&& echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
&& apt-get update -qq \
&& apt-get install -y build-essential libpq-dev nodejs yarn
RUN mkdir /try-hotwire
WORKDIR /try-hotwire
RUN gem install bundler:2.3.17
COPY Gemfile /try-hotwire/Gemfile
COPY Gemfile.lock /try-hotwire/Gemfile.lock
COPY yarn.lock /try-hotwire/yarn.lock
RUN bundle config set force_ruby_platform true
RUN bundle install
RUN yarn install
COPY . /try-hotwire
