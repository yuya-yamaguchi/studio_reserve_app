<img width="1440" alt="readme_top" src="https://user-images.githubusercontent.com/56626222/72522654-8cb84c80-38a1-11ea-8dbd-620e47f9ea3a.png">

# アプリURL
http://18.177.101.206:3000/
* ログインID: a@gmail.com
* ログインPASS: 12345678

# アプリ説明
## アプリ概要
音楽スタジオ「Hummingbird」（京都府伏見区）の専用サイト<br>
当スタジオの予約や会員同士でのセッション（演奏会）の開催などを行うことができる<br>
（※個人所有のスタジオ、2020年4月より実運用予定）

## 作成背景
所属してる音楽サークルで使用している個人所有スタジオがあり、<br>
サークルメンバは自由にスタジオの利用が可能である。<br>
現在はGoogleスプレッドシートで予約管理しており不便であること、<br>
サークルメンバも多くなってきたことから（2020年1月現在、60名超）<br>
専用ページを作成するに至った。

## 開発環境
* フロント： HTML(haml), css(sass), JavaScript(Jquery)
* バック： Ruby(2.5.3)
* フレームワーク: Rails(5.2.3)
* DB: MySQL(5.7)
* インフラ: AWS(EC2), Docker

## ER図
<img width="1284" alt="studio_reserve_app_ER" src="https://user-images.githubusercontent.com/56626222/72574880-05ed8900-390e-11ea-8df1-f3759cd8963b.png">

## 機能紹介
### スタジオ予約機能
![result](https://user-images.githubusercontent.com/56626222/72571290-86a68800-3902-11ea-83bc-b5e4ed96b205.gif)
スタジオ一覧から予約したいスタジオを選択し、<br>
遷移後に表示される予約表から予約が可能。<br>
・予約可能期間：本日日付〜半年の10:00〜22:00<br>
・予約取消：予約日の前日まで<br>


### セッション（演奏会）開催・参加機能
<img width="1070" alt="readme_session" src="https://user-images.githubusercontent.com/56626222/72523302-d5243a00-38a2-11ea-8ef1-bfc9bf9af601.png">
セッション（演奏会）の開催・参加が可能。

#### セッションを開催する場合
・セッション一覧ページ、またはヘッダーの「セッションを開く」からセッションの登録が可能<br>
・セッション登録時にセッション名や開催日時、スタジオを登録。<br>
この際、スタジオは自動予約されます。<br>
・主催者（開催者）はセッションの中止を行うことができ、<br>
中止した場合、セッション参加者に中止の旨が通知され、<br>
その時間帯のスタジオ予約も自動キャンセルとなります。

#### セッションに参加する場合
・セッション一覧から参加したいセッションを選択後、右上の「参加する」ボタンから参加可能です。<br>
・セッションの参加後、「参加をやめる」ボタンが表示され、セッション参加の取消が可能となります。<br>
参加をやめた場合、エントリーしていたパートは自動キャンセルとなります。（エントリーした曲は残ります）

#### 曲・パートのエントリー
・セッション参加後、曲およびパートののエントリーが可能となります。<br>
・曲を追加する場合、「曲を追加する」ボタンを押下し、曲名や必要パートの要不要を<br>
入力することで、曲のエントリーが可能です。曲のエントリーを削除する場合、<br>
曲名のリンクを押下し、遷移先の削除ボタンから削除可能です。<br>
・パートにエントリーする場合、セッション曲一覧からエントリーしたい曲のパートを選択することで<br>
エントリーが完了します。エントリーをやめる場合、名前の下に表示されている「×ボタン」にてやめることができます。

### 掲示板・メッセージ機能
<img width="1085" alt="readme_post" src="https://user-images.githubusercontent.com/56626222/72523301-d5243a00-38a2-11ea-9cbc-c9d8e7a14117.png">
会員同士のコミュニケーションを目的とした掲示板です。
バンドメンバーの募集や参加希望など、自由に書き込んでください。

### マイページ
<img width="1074" alt="readme_mypage" src="https://user-images.githubusercontent.com/56626222/72523300-d5243a00-38a2-11ea-9d4f-753fc608be0d.png">
マイページにてユーザ情報の確認が可能です。
セッションでの演奏回数など、ユーザに関連する情報の確認が可能です。
