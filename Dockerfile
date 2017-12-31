FROM ruby:2.5-alpine

RUN mkdir -p /app/cryptobot

WORKDIR /app/cryptobot

COPY Gemfile /app/cryptobot
COPY Gemfile.lock /app/cryptobot

RUN bundle install

COPY . /app/cryptobot

CMD ["ruby", "lib/crypto_bot.rb"]
