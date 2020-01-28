<img src="https://camo.githubusercontent.com/c902f2404c5a3a0d8fd2755fed83d7bc272f2c90/68747470733a2f2f63646e2d696d616765732d312e6d656469756d2e636f6d2f6d61782f3935392f312a5163305878596d2d71415a4c2d37746a6a6c4e6672672e706e67" width="100" data-canonical-src="https://cdn-images-1.medium.com/max/959/1*Qc0XxYm-qAZL-7tjjlNfrg.png" style="max-width:100%;">
<img src="https://camo.githubusercontent.com/fb3c0ba1d4429fadfcc57570b9d09d6ccfa3485d/687474703a2f2f69322e77702e636f6d2f73616d616e6368612e636f6d2f77702d636f6e74656e742f75706c6f6164732f323031372f31322f7261696c732e706e673f6669743d363030253243363030" width="100" data-canonical-src="http://i2.wp.com/samancha.com/wp-content/uploads/2017/12/rails.png?fit=600%2C600" style="max-width:100%;"><img src="https://camo.githubusercontent.com/2d55d4674cbece49bf275344665ee22ed2f0f621/687474703a2f2f662e73742d686174656e612e636f6d2f696d616765732f666f746f6c6966652f6e2f6e6970653838303332342f32303134313030312f32303134313030313030353932382e706e673f31343132303932383839" width="140" data-canonical-src="http://f.st-hatena.com/images/fotolife/n/nipe880324/20141001/20141001005928.png?1412092889" style="max-width:100%;">
<img src="https://camo.githubusercontent.com/986b1f98f3bbbb12511cf92d052180ac80a83ea2/68747470733a2f2f75706c6f61642e77696b696d656469612e6f72672f77696b6970656469612f636f6d6d6f6e732f7468756d622f392f39362f536173735f4c6f676f5f436f6c6f722e7376672f3132303070782d536173735f4c6f676f5f436f6c6f722e7376672e706e67" width="100" data-canonical-src="https://upload.wikimedia.org/wikipedia/commons/thumb/9/96/Sass_Logo_Color.svg/1200px-Sass_Logo_Color.svg.png" style="max-width:100%;">
<img src="https://camo.githubusercontent.com/e0e3e4ad47134bff0f4d1f01c8e0882b2240c486/68747470733a2f2f7777772e6d7973716c2e636f6d2f636f6d6d6f6e2f6c6f676f732f6c6f676f2d6d7973716c2d313730783131352e706e67" width="140" data-canonical-src="https://www.mysql.com/common/logos/logo-mysql-170x115.png" style="max-width:100%;">
<img src="https://camo.githubusercontent.com/db33ab2aa62a11d106bb6ff55bd38b4db2a1cbeb/68747470733a2f2f61302e6177737374617469632e636f6d2f6c696272612d6373732f696d616765732f6c6f676f732f6177735f6c6f676f5f736d696c655f31323030783633302e706e67" width="100" data-canonical-src="https://a0.awsstatic.com/libra-css/images/logos/aws_logo_smile_1200x630.png" style="max-width:100%;">
<img src="https://www.docker.com/sites/default/files/d8/styles/role_icon/public/2019-07/Docker-Logo-White-RGB_Vertical-BG_0.png?itok=8Tuac9I3" width="100">

# アプリURL
https://studio-hummingbird.com/<br>
<h2>【一般ユーザ】</h2>

* ログインID: a@gmail.com
* ログインPASS: 12345678

<h2>【管理ユーザ】</h2>

* ログインID: kanri@gmail.com
* ログインPASS: 12345678

# アプリ説明
## アプリ概要
音楽スタジオ「STUDIO-Hummingbird」（京都府伏見区）の専用サイト<br>
当スタジオの予約や会員同士でのセッション（演奏会）の開催などを行うことができる<br>
実運用を想定し、想定外のエラー時は原因特定のため、エラーログ(DB)を作成<br>
また、同一トランザクション内で処理を行い、DBの整合性を担保<br>
（※個人所有のスタジオ、2020年4月より実運用予定）

## 作成背景
所属してる音楽サークルで使用している個人所有スタジオがあり、
サークルメンバは自由にスタジオの利用が可能である。<br>
現在はGoogleスプレッドシート等で予約管理しており、不便であること、
またサークルメンバも多くなってきたことから（2020年1月時点、60名超）
専用ページを作成するに至った。

## 開発環境・使用技術
* HTML(haml)
* css(sass)
* JavaScript(Jquery)
* Ruby(2.5.3)
* Rails(5.2.3)
* MySQL(5.7)
* AWS(EC2, route53, ELB)
* Docker(3.7.3)
* Docker-compose(1.24.1)

## ER図
<img width="1261" alt="er_graph" src="https://user-images.githubusercontent.com/56626222/73163803-0a971600-4134-11ea-9473-d6ae70f91f7a.png">

## 機能概要
### スタジオ予約機能
* スタジオ一覧の各スタジオ詳細ページから予約可能（ユーザ登録要）
* 本日〜半年の10:00〜22:00で予約が可能
* 予約日の前日まで、予約の取消が可能
* 予約時は日付、時間帯のチェック処理を実施（終了時間は開始時間以降であることのチェック、重複予約のチェック等）

![result](https://user-images.githubusercontent.com/56626222/72571290-86a68800-3902-11ea-83bc-b5e4ed96b205.gif)

### ユーザ登録機能
* メールアドレスによるユーザ登録が可能(devise使用)
* ユーザ登録後、マイページよりユーザ情報の編集が可能(氏名、プロフィール、画像の設定等)

### セッション（演奏会）開催・参加機能
* セッションの登録、編集、中止が可能(セッション登録時は指定の時間でスタジオを自動予約、キャンセル時はスタジオも自動キャンセルし、参加者へお知らせを通知)
* セッションへの参加、参加取りやめが可能(参加取りやめ時はエントリーパートを自動キャンセル)
* セッション参加後に曲の追加・編集・削除、各パートへのエントリーが可能
* 開催日時、キーワードにてセッションの検索が可能
* マイページに参加パート数の累計をグラフにして出力
* マイページにそのユーザが主催したセッション、参加したセッション一覧を表示
<img width="1070" alt="readme_session" src="https://user-images.githubusercontent.com/56626222/72523302-d5243a00-38a2-11ea-8ef1-bfc9bf9af601.png">

### 掲示板・メッセージ(DM)機能
* 掲示板への記事投稿・編集・削除が可能
* 記事の種類、キーワードでの検索が可能
* マイページにそのユーザが投稿した記事一覧を表示
* 他ユーザのマイページからそのユーザに対するメッセージ送信が可能
* メッセージの未読・既読機能を実装(LINEのような形式で表示される)
* メッセージ一覧から各ユーザとのやり取りの確認が可能
<img width="1085" alt="readme_post" src="https://
user-images.githubusercontent.com/56626222/72523301-d5243a00-38a2-11ea-9cbc-c9d8e7a14117.png">

### マイページ
<img width="1074" alt="readme_mypage" src="https://user-images.githubusercontent.com/56626222/72523300-d5243a00-38a2-11ea-9d4f-753fc608be0d.png">

### 管理機能
* 管理者権限を持つユーザのみスタジオ情報の編集、ユーザ一覧の閲覧等が可能(active_adminを使用)

### システムエラー(想定外のエラー)時の動作
* 想定外のエラーが起こった場合、エラーログ(DB)を作成し、システムエラー画面へ遷移する
* 複数テーブル、レコードの更新時は同一トランザクション内で処理を行い、DBの整合性を担保
