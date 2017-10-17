# Explanation

- rails勉強会の概要を書きます

## 基礎知識

### railsとはフレームワークの一種である

- プログラミングには[再利用](https://ja.wikipedia.org/wiki/%E3%82%B3%E3%83%BC%E3%83%89%E3%81%AE%E5%86%8D%E5%88%A9%E7%94%A8)という重要な概念があり、誰か他の人が作ったものは「使い方をしっかりと理解していれば」、簡単に誰でも再利用できるということである。
- その誰かが他の人が作ったカタマリを「フレームワーク」と呼ぶ
- フレームワークを使うときはその使い方、すなはち本家のドキュメントをしっかり読むことが重要である

### railsの設計思想

- railsの主な設計思想は[1]

  1. プログラマーの幸福度の最適化
  2. 設定より規約

- 簡単にいうと、スピードとかパフォーマンスyよりも、とにかく開発者が楽しくなるような言語にして、開発者の生産性をあげてくれるようなフレームワーク

- 短時間でスピーディーに開発ができるが、サービスが大きくなるに連れてパフォーマンスが落ちていき、使いにくくなる

- スタートアップのサービス（短時間でそれなりのサービスを作りたい）やハッカソンなどで使うのに適していると思う

### RubyはObject指向である

- rubyでは、何かの値を見つけたときに「それがどのclassに属しているか」「それがどのようなmethodを持っているか」が重要である
- 以下の6つが主なclassである

  - fixnum(int)
  - float
  - string
  - array
  - hash
  - nil

### なぜサーバーを立てるか

- ただ単にrubyでプログラムを組んだだけでは、shellから実行しないと実行されない。それをURLにアクセスした時点で何かのプログラムを実行させるようにしたものが、サーバーサイドである

- - 例えばあだ名を返すrubyプログラムを書いてみるとする。以下のようにして実行する

  `sample/arima.rb`

  ```bash
  ruby sample/arima.rb なまえ
  ```

- 上のプログラムをサーバーに載せると<http://localhost:3000/adana/なまえ>にアクセスすると、プログラムが実行される

## railsの読み方

- 先ほどのあだ名を作成するAPIで説明する
- railsは route -> controller -> viewer の順でコードを読む

### route

- まずは`config/route.rb`をみる。ここには、URLの定義が書いてある。

```ruby
  get '/adana/:name', to: 'application#adana'
```

- これは「`localhost:3000/adana/(何しらのなまえ)`にアクセスすると、`app/controller/application_controller.rb`の`adana`メソッドを実行する」という意味である

### controller

- routeのあとはcontrollerに入る。今回は`application_controller.rb`だが、どのコントローラでも良い。controllerには色々な処理をかく（正式にいうとDatabaseを扱う処理を記述する）

  ```ruby
  def adana
  after = [
    "ぽん",
    ...
  ]

  before = [
    "T-",
  ....
  ]

  @adana = before[Random.rand(0..before.length)] + params[:name] + after[Random.rand(0..after.length)]
  render template: "adana/index"
  end
  ```

- あだ名を生成し、`@adana`という変数に入れている

- `render template: "adana/index"`で、表示するhtmlは`app/viewer/adana/index.html.erb`を使用することを明示している

### viewer

- viewerとは、どのようなhtmlで表示するかを決定する。実際には拡張子が`html`ではなく`html.erb`なのでhtmlの中に`<%= ... %>`の記号でrubyを埋め込むことができる

```ruby
<h1><%= @adana %></h1>
```

- ここでは`@adana`に入った変数をh1タグで表示している

## Databaseについて

### Dataの永続化

- プログラミングではDataの[永続化](https://ja.wikipedia.org/wiki/%E6%B0%B8%E7%B6%9A%E6%80%A7)が重要となる。永続化をざっくりというと、「どのようにデータを保存するか？」である

- サーバーサイドプログラミングではDatabaseというものがよく用いられる

## SQL

- databaseをいじるのには`SQL`というデータベース固有の言語を用いる
- 代表的な操作は以下の通りである(頭文字をとってCRUDという)

  - create:データを作成する

    ```sql
    INSERT INTO
    users
    (name, mail, created_at, updated_at)
    VALUES
    ('yamada', 'yamada@asd', '2017-7-4', '2017-5-6');
    ```

  - read(get):条件に適したデータをとってくる

    ```sql
    SELECT
        name, created_at
    FROM
      users
    WHERE
        id > 90
    AND
        id < 100
    ;
    ```

  - update:データを更新する

    ```sql
    UPDATE
        users
    SET
        name = 'Alfred Schmidt',
        mail= 'Frankfurt'
    WHERE
        id = 10;
    ```

  - delete:データを削除する

    ```sql
    DELETE
    FROM
        users
    WHERE
        name='ユーザー10'
    ;
    ```

## Active Record

- Active RecordとはSQLをrubyのコードっぽく書いたものである（railsでは普通こちらを使う）

- railsのlogをみてわかるように、Active Recordは結局SQLに変換される

- 代表的な操作は以下の通りである(頭文字をとってCRUDという)

  - create:データを作成する

    ```ruby
    @user = User.create(name: "yamada", mail: "yamada@gmail.com")
    ```

  - read(get):条件に適したデータをとってくる

    ```ruby
    @user = User.where(name: "yamada")
    ```

  - update:データを更新する

    ```ruby
    User.where(id: 1).update(name: "kato", mail: "jo@gamil.com")
    ```

    もしくは

    ```ruby
    @user = User.where(id: 1)
    @user.name = "kato"
    @user.mail = "jo@gmail.com"
    @user.save
    ```

  - delete:データを削除する

    ```ruby
    User.where(id: 4).destroy_all
    ```

## Ref

- <https://ja.wikipedia.org/wiki/%E3%82%B3%E3%83%BC%E3%83%89%E3%81%AE%E5%86%8D%E5%88%A9%E7%94%A8>
- <https://ja.wikipedia.org/wiki/%E6%B0%B8%E7%B6%9A%E6%80%A7> -
