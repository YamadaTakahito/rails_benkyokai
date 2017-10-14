# Setup

## Docker

1. 開発はDocker上で行います。Dockerについての説明は省きますが、[ここのURL](https://store.docker.com/editions/community/docker-ce-desktop-mac)からDocker for Macをインストールしてください
2. Dockerをインストールし、立ち上げてください。Dockerが立ち上がると上のバーのクジラの潮吹きが止まります（Dockerを立ち上げっぱなしにすると重いので、この講座が終われば閉じましょう）
3. ターミナルを開き、以下のコマンドを実行してください

  `git clone https://github.com/YamadaTakahito/rails_benkyokai.git && cd rails_benkyokai && make dev`

4. `rails s`を実行し、[localhost:3000](http://localhost:3000/)にアクセスします。みんながわっしょいやってたら成功です。もしできなかったら@YamadaTakahitoに聞いてください。

(DBのport番号の原因である場合が多い。`docker-compose.yml`のDBのportをいじればいいかも)

## Postico

1. [Postico](https://eggerapps.at/postico/)をインストールしてください。金払え的なことを言われても無視して構いません
2. Posticoを立ち上げたあと、以下のように入力してください

  - New Favoriteをおす
  - Nicknameは`rails_benkyokai`
  - Hostは`localhost`
  - Portは`5432`(人によるかも)
  - Userは`postgres`
  - passwordは`password`

3. Connectを押して終了です
