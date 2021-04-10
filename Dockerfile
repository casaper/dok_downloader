FROM ruby:3.0.0

COPY entrypoint.sh /usr/bin/
COPY . /app

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
  # && mkdir /app \
  && groupadd -g 1000 app \
  && useradd -m -g 1000 -u 1000 -G users app \
  && chown -R app:app /app \
  && chmod +x /usr/bin/entrypoint.sh

ENV RAILS_ENV production
ENV RAILS_LOG_TO_STDOUT true

WORKDIR /app
USER app

RUN bundle config set --local without 'development test' \
  && bundle config set --local frozen 'true' \
  && bundle install --no-cache \
  && yarn install

EXPOSE 3000
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
CMD ["bin/rails", "server", "-b", "0.0.0.0"]
