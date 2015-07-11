# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Question.create([
  {title: 'Nokogiriのgemがインストールできない', body: 'スクレイピングをしてみたいと思い、Nokogiriのgemをインストールをしようとしたのですが、エラーが出てしまい、それに対応していたら最終的に下記のようなエラーになり全く太刀打ちができなくなってしまいました。 '},
  {title: 'Railsで任意のルーティングを通したいのですが、ハマっています', body: '現在RailsでWebアプリケーションを作っているのですが、ルーティングの部分で解決できない問題があり、わかる方に教えていただければと思います。'},
  {title: 'railsのlink_toに入れ子で要素を追加したい', body: 'railsのlink_toに入れ子で要素を追加したい'},
  {title: 'Could not send a confirmation email from heroku', body: "Could not send a confirmation email from heroku. I'm trying to send it with heroku rails and sendgrid and I can't maybe because of this error. sh: 1: /usr/sbin/sendmail: not found ..."},
  {title: 'Railsチュートリアルでgem updateでシステムのバージョンが上げられない。', body: 'gem updateを実行したところエラーが吐かれてしまいシステムのバージョンを変えることが出来ませんでした。 検索してファイヤーウォール等の設定を見直したのですが、 何度やっても同じエラーが出力され、システムのバージョンを合わせることが出来ません。'},
  {title: 'RubyOnRails でログアウトした後にブラウザの戻るボタンで戻れてしまう', body: 'ログアウトをして、トップページなどにリダイレクトした後、ブラウザの戻るボタンでログイン中でしか見れないページが見えてしまいます。 直し方が分かりません。'},
  {title: 'Rails&wicked_pdfによるPDF出力について', body: '現在、以下の環境でPDFを帳票出力しています。 CentOS6.6 Rails 4.0.2 ruby 2.1.0 wkhtmltox-0.12.2.1 wicked_pdf 0.11.0 この環境でHTMLのテーブルで帳票レイアウトし、PDFを出力し、テーブルがページをまたがると、またがった方のページの帳票の レイアウトが崩れてしまいます。'},
  {title: 'ドットインストール Rails：TaskContlloerが生成できない', body: 'ドットインストールでのTaskAppを学習していたところ、 プロジェクト内で、Taskを追加していく処理ができなくてつまずいています。 class TasksController < ApplicationController def create ...'},
  {title: 'rails のwhere句の結果を指定の順番で取り出す方法は？', body: 'dsはArrayで中にPostモデルの取り出したいidが先頭から順番に入っています。 ids = [23, 12, 34, 45, 9] これとwhere句を使ってPostを取り出すことはできていますが、順番が意図している順序になりません。 '},
  {title: 'bundle install で RMagick が入らない', body: 'Yosemite 10.10.4，Ruby 2.2.0 bundle install で RMagick が入らないのです。普通に gem install なら入りました。 ビルドがコケてるようなんですが、 何が問題なのかエラーを見てもわからず、教えていただきたいです。'},
  {title: 'Rails loggerがローテーションしない', body: 'Ruby 2.2.2、Rails 4.2.1 にて以下のやり方でログを出力しています。'},
  {title: '複数のscopeの結果をひとつにまとめる方法は？', body: 'Railsのあるmodelで複数のscopeを使いオブジェクトの並べ方を定義しています。'},
  {title: 'Rails経由でPostgresqlの機能を使って偏差値を求める', body: '全モデルの中での偏差値を求めたく、現在は全件取得してきて自分で実装した方法で特定のカラムの値からその偏差値を求めているのですが、これをPostgresqlの機能で行うことはできますか？'},
  {title: 'Rails4.2 HerokuでRedis使用時にキューが入らない', body: 'sidekiqを使い、メールの遅延処理を実装しました。 heroku上で動作確認をしたところNo such file or directory - ./log/sidekiq.logとエラーがでます。'},
  {title: 'Rails アプリのCSSが効かなくなります。', body: 'Rails4で作成したアプリをHerokuにデプロイすると、CSSが効かなくなります。\nデプロイした時はCSSが効いていても、数時間後あるいは翌日にアクセスするとCSSが効かなくなっています。これはどういうことなのでしょうか？ずっとこのような事態が続いています。'},
  {title: 'Rails4.2 iPhoneのブラウザから更新すると画像が更新されてしまう', body: 'herokuにアプリをアップしました。 macbookのsafariからテストした時は問題なかったのですが、iPhoneからsafariとchromeテストした際に下記の問題が起きました。'},
  {title: 'ドットインストールでタスクappをrailsでのつまづき', body: "NoMethodError in TasksController#create undefined method `tasks' for nil:NilClass このようなエラーが出ました。 どなたかヒントをくださると助かります。 アバウトな質問でごめんなさい。"},
  {title: 'Rails 4.2 階層を持った URL の静的ページを1つのコントローラーでルーティングしたい', body: 'Ruby on Rails のルーティングについてです。 複数の半静的ページを1つのコントローラーで制御しようとしています。 config/routes.rb に全ページ分 get メソッドを書くのも辛いので、下記のように書きました。'}
])