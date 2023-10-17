FROM ruby:2.4

RUN apt-get update && \
    apt-get install -y texlive-full imagemagick

RUN wget https://github.com/jgm/pandoc/releases/download/1.19.2.1/pandoc-1.19.2.1-1-amd64.deb && \
    dpkg -i pandoc-1.19.2.1-1-amd64.deb

RUN gem install bundler -v 2.3.26

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g bower

ADD . /code
WORKDIR /code

RUN bundle install
RUN bower install --allow-root
