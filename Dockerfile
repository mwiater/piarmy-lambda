FROM armhf/alpine

RUN apk update && apk upgrade && \
  apk add --no-cache \
  build-base sudo bash nano \
  ruby ruby-dev ruby-rdoc ruby-irb ruby-io-console

RUN echo "docker ALL=(root) NOPASSWD:ALL" | tee -a /etc/sudoers && \
  addgroup -S docker && \
  adduser -S -g docker -s /bin/bash docker && \
  echo "docker:docker" | chpasswd

COPY containerFiles /home/docker/www

USER docker

WORKDIR /home/docker/www

RUN cd /home/docker/www && \
  sudo chmod 777 -R ../www && \
  sudo chown docker:docker -R ../www && \
  sudo gem install bundler && \
  bundle install

EXPOSE 8002

CMD ["bundle", "exec", "puma", "config.ru", "./config/puma.rb"]