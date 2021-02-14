#開発しているアプリのrubyのバージョンを指定
FROM ruby:2.6.5

#パッケージのインストール
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq \
    && apt-get install -y nodejs yarn

#作業ディレクトリの指定
WORKDIR /app

#アプリのgemfileやgemfile.lockを読み込んでbundle installで反映
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN gem install bundler
RUN bundle install

#ホストのアプリケーションディレクトリ内をすべてコンテナappにコピー
COPY . /app

#ポートの送信(localhost:3000でアクセスするための記述)
EXPOSE 3000

#実行するコマンドや引数を定義している。(後々docker runコマンドを実行する際に動く)
CMD ["rails", "server", "-b", "0.0.0.0"]