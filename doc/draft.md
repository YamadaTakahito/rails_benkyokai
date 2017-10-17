# Railsの設計思想

- railsとはフレームワークの一種である

  - フレームワークとはカレー粉みたいなものである
  - プログラミングというには「[再利用](https://ja.wikipedia.org/wiki/%E3%82%B3%E3%83%BC%E3%83%89%E3%81%AE%E5%86%8D%E5%88%A9%E7%94%A8)」という重要な概念があり、誰かが作ったものは「使い方をしっかりと理解していれば」、簡単に誰でも再利用できるということである
  - カレー粉においても同様である。もしカレー粉がなかったら、一般人は色々なスパイスを調合してカレーを作らないといけない。もしそうなら、カレーは一般家庭に普及していなかった。でも、企業がいい感じにスパイスを調合してカレー粉を作り、ただお湯で溶かせばカレーを作れるようにしてくれた。これによって、より多くの人にカレーが普及した
  - 同様に、どこかの天才がいい感じにプログラミングを作ってくれ、それを公開してくれたことで、素人でもそれなりの製品が作れるようになった。そのどこかの天才が作ってくれたいい感じのものをフレームワークとよぶ。
  - 例えばReactはJavaScriptのフレームワーク、RailsはRubyのフレームワーク、Djangoはpythonのフレームワーク、WordPressはPHPのフレームワークである。
  - フレームワークを作る際に大事なのは「使い方をしっかりと理解する」こと。カレー粉も説明書を読まず、自分のアドリブで電子レンジにいれてもカレーはできない。
  - 多くのエンジニアが、「本家のドキュメントをしっかりと読め」と行っているのは、「フレームワークを作った本人が書いた説明書をしっかりと理解しろ」ということ
  - あなたも何か作ったら、他の人のためにちゃんとドキュメントを書きましょう。これはマナーです。

- なんのプログラミング言語を使うかは重要ではない。自分が何をしたいかが先で、それを実現するために結果的にプログラミング言語は選ばれるのである。

  - railsの主な設計思想を2つあげると[1]

    1. プログラマーの幸福度の最適化
    2. 設定より規約

  - 簡単にいうと、スピードとかパフォーマンスとか細かいことはどうでもいいから、とにかく開発者が楽しくなるような言語にして、開発者の生産性をあげてくれるような言語

  - 個人的には短時間でスピーディーに開発ができるが、サービスが大きくなるに連れてパフォーマンスが落ちていき、使いにくくなる

  - だからスタートアップのサービス（短時間でそれなりのサービスを作りたい）やハッカソンなどで使うのに適していると思う

  - ただrailsを使うのではなくて、なんでrailsを使うのかが大切 1.

- どのようにrailsが使われていたか

  - twitterの例をあげる
  - twitterは、サービスができた2006~2011年くらいまではrailsを使っていた。しかし、その後Javaに書き換えた
  - 創業当初は時間もなく、ideaをパクられる可能性もあるので、なる早で作りたかったのだろう。だからrailsを採用したに違いない
  - しかし、userが増えてくるに連れてパフォーマンスが落ち、どんどん使いにくくなってきたのでjavaに移行したのだろう
  - 例えばrailsとjavaで、同じ処理を行うと0.01s,Javaの方が早いとする。創業初期のuserが100人の頃は100 x0.01s=1sくらいの差だが、100万人を超えると1000000x0.01 = 10000sとなる。さすがにこれは辛い

# RubyはObject指向

- rubyはObject指向の言語であり、Object指向の中でも過激派である

## Object指向とは何か

- とても難しいので、詳しいことは他の本に譲る。ここでは、iPhoneの設計を例としてざっくりとObject思考を理解する。

  - iPhoneは様々部品の組み合わせで成り立っている。ディスプレイ、モータ、CPUなどである。それらの部品は別々に作られて、その後それぞれの部品を組み合わせることによってiPhoneという複雑な機械を作っている。
  - それぞれの部品は、特定のことに特化した塊で、色々な機能（メソッド）を持っている。例えばディスプレイは光を表示することに特化したもので、赤や黄などの光を出すという機能（メソッド）をもつ。CPUは計算をすることに特化したもので、掛け算や足し算などの機能（メソッド）をもつ
  - なぜこのように部品に別れているかというと、まずは品質管理がしやすいからだろう。ディスプレイを作る会社は画面を表示することだけを考えればいいだけで、他のことを考えなくていい。iPhoneという複雑な機械を故障なく作ることはすごく難しいが、ディスプレイを故障なく作ることはそこまで難しくない。ディスプレイ会社は画面を表示することのみを考えればいいので、高品質なものを作ることができる。
  - もう一つの理由としては、再利用できることだ。iPhoneだけを作る会社だと、iPhoneしか作ることができない。しかし、ディスプレイ会社はiPhoneでもNexusでもXperiaでも使いまわすことができる。
  - このようにiPhoneのような複雑なサービスを作るときは同じ考え方ができる。それぞれの機能を切り出して、意味を持ったまとまりに分けることでプログラムが組みやすくなる。iPhoneのたとえでいうと、iPhoneはDisplay class, CPU class, motor classを持っている。それぞれのclassは、様々なmethodを持っていて、例えばdisplay classはdisplayというLEDで光を表示する関数がある。それぞれのclassは、そのclassないで求めれている機能をちゃんとできることを考えればいいので、プログラムが組みやすくなる。そして、Display class, CPU class, motor classを継承すれば、iPhone classという複雑なものを作ることができる
  - このように、ある程度意味を持ったまとまり（Object）を分けることで、プログラムがしやすくなる
  - 重要なのはいかにしてうまく、Objectに分けられるかということである。iPhoneのたとえでいうと、モータとディスプレイはすごく使いやすい部品であるが、半分モータの機能を持っており、半分ディスプレイの機能を持っているような中途半端な部品は使い物にならないということである。だから、プログラムをするときも、いかにしてうまく意味を持ったまとまりのあるObjectに切り出せるかが重要だ（これが結構難しい）

## RubyにおけるObject指向

- まずはその変数なり値が、どのobjectか、すなわちどのclassに属しているかを知らないといけない

- そして、そのclassがどのようなメソッドを持っているかを知らないといけない

- 以下の6つが主なclassである

  - fixnum(int)
  - float
  - string
  - array
  - hash
  - nil

# なぜサーバーを立てるか

## 理論

- 例えばあだ名を返すrubyプログラムを書いてみるとする。以下のようにして実行する

  `sample/arima.rb`

  ```bash
  ruby sample/arima.rb 山田
  ```

- 例えば、100万人のuserに対してあだ名を作ってあげようとすると、100万回上のやつを実行するのは不可能。よってそれぞれのUserが特定のURLにアクセスして、あだ名を返す仕組みを作ればいい

- <http://localhost:3000/adana/なまえ>にアクセスして見よう

- `config/routes.rb`でどのURLに飛んだら、どのコントローラーにアクセスするか決定する。今回の場合は<http://localhost:3000/adana/なまえ>にアクセスすると、`app/controller/application_controller.rb`の`adana`メソッドが実行される

`config/routes.rb`

```ruby
  get '/adana/:name', to: 'application#adana'
```

- あだ名を生成し、`@adana`という変数に入れる。`render template: "adana/index"`によって、`app/views/adana/index.html.erb`の規則にしたがったhtmlを表示する。基本的に表示するときは@で始まる変数でないといけない

`app/controller/application.rb`

```ruby
def adana
  after = ["ぽん"]
  before = ["T-"]

  @adana = before[Random.rand(0..before.length)] + params[:name] +after[Random.rand(0..after.length)]
  render template: "adana/index"
end
```

- `@adana`という変数をh1タグで表示する

`app/views/adana/index.html.erb`

```html
<h1><%= @adana %></h1>
```

## 演習

- `/konitiwa/<なまえ>`とアクセスすると、`こんにちは<なまえ>さん`と表示されるアプリを作って見よう

# Databaseについて

## Dataの永続化？

- Dataの[永続化](https://ja.wikipedia.org/wiki/%E6%B0%B8%E7%B6%9A%E6%80%A7)とはざっくりいうとどのようにデータを残すか？である。

- SDカードでもURBメモリでもいいのだが、よく用いられるのはDatabaseというものである。[Postico](https://eggerapps.at/postico/)で見てみるとわかる通り、Excel シートみたいなものである。

## SQL

- databaseをいじるには`SQL`というプログラミング言語を用いる。基本の操作のCRUDは以下の通り

- create

```sql
INSERT INTO
  users
  (name, mail, created_at, updated_at)
VALUES
  ('yamada', 'yamada@asd', '2017-7-4', '2017-5-6');
```

- get(read)

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

- update

```sql
UPDATE
    users
SET
    name = 'Alfred Schmidt',
    mail= 'Frankfurt'
WHERE
    id = 10;
```

- delete

```sql
DELETE
FROM
    users
WHERE
    name='ユーザー10'
;
```

## Active Record

- Active RecordとはSQLをrubyのコードっぽく書いたものである
- railsのlogを見てもわかる通り、結局はSQLに変換される
- このようなデータベース固有の言語であるSQLを、各言語に対してわかりやすくしたフレームワークをO/R Mapper(Object Relational Mapping)と呼ぶ。railsならActive Record, Djangoならdjango ORM, Go ならGormなどがある。
- 別にO/R Mapperを使わなくてもデータベースはいじれるけど、ほとんどの人はO/R Mapperを使う。O/R Mappperを使った方がわかりやすいから（超上級者はSQLでかく）
- 以下のコードを`rails c`で実行して見よう
- create

```ruby
@user = User.create(name: "yamada", mail: "yamada@gmail.com")
```

- get(read)

```ruby
@user = User.where(name: "yamada")
```

- updated

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

- delete

```ruby
User.where(id: 4).destroy_all
```

### User controllerとUser viewerを参考にCRUDを行うものを考えて見よう

# ref

- <http://postd.cc/rails-doctrine/>
