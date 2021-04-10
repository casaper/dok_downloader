FROM ruby:3.0.0

RUN apt-get update -yq \
  && apt-get install --no-install-recommends -yqq \
    gnupg curl python3-pip \
    # for embedding thumbnails into m4a files 
    atomicparsley \
    # for video post-processing 
    ffmpeg \
    # for some less common extractors to work
    phantomjs \
    # for rtmp streams support
    rtmpdump \
  && curl -sL https://deb.nodesource.com/setup_14.x | bash \
  && apt-get update -yq \
  && apt-get install --no-install-recommends -yqq nodejs \
  && curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor > /usr/share/keyrings/yarnkey.gpg  \
  && echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" > /etc/apt/sources.list.d/yarn.list \
  && apt-get update -yq \
  && apt-get install --no-install-recommends -yqq yarn \
  && pip3 install youtube-dl \
  && apt-get clean \
  && mkdir /app

ENV RAILS_ENV production
ENV RAILS_LOG_TO_STDOUT true

ADD . /app
WORKDIR /app

RUN bundle config set --local without 'development test' \
  && bundle config set --local frozen 'true' \
  && bundle install --no-cache \
  && yarn install --link-duplicates --production \
  && bin/rails webpacker:compile \
  && bin/rails assets:precompile \
  && rm -rf vendor/* tmp/cache/*

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
EXPOSE 3000
CMD ["bin/rails", "server", "-b", "0.0.0.0"]
