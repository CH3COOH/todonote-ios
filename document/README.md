# Documents

以下は、TodoNote の開発資料である

## コンセプト

* オフラインでも利用可能な TODO 管理アプリ
* ユーザーにネットワーク状態を意識させない

## 現時点での制約

* Firebase Auth の匿名ログインを利用しており、Twitterアカウントでのログインなどの追加認証方法を提供していない。このため一度ログアウトしてしまうと、サーバーに保存したデータにはアクセスできなくなる。よって、現在時点では ログイン時にサーバーからのデータ取得という処理は実装していない
* 現時点では、TODOアイテムの登録・編集時にアプリを kill された場合、次回のアプリ起動時に編集中のアイテムがあるかどうか調べて、途中から復帰できない

## 画面遷移図

<img width="749" alt="screen-transition" src="https://github.com/CH3COOH/todonote-ios/assets/137952/dbdc0ac1-96f2-4873-ade5-7f9c9cbc7da1">

## TODOアイテムについて

TODOアイテムは、ローカル(アプリ内データベース) と バックエンド (Firestore) にて管理する。

### TODOアイテムのステータスについて

* TODOアイテムは「editing」「ready」「complete」の3つのステータスを持つ
    * `editing` は 編集中
    * `ready` は、準備完了
    * `complete` は、バックエンドへの同期済み

### TODOアイテムの登録/編集処理

登録時・編集時の処理の詳細は、[データベースの仕様](./Database.md) にて記す。以下は簡単なデータフローの説明である。

* ステータスが `ready` のアイテムは、TODOアイテムの保存時・アプリ起動時に バックエンドへ同期する
    * オフラインでもエラーを表示しない
* ステータスが `editing` のアイテムは、TODO登録画面以外では存在させない
    * 登録画面上でアプリを終了させた場合、`editing`のレコードが残るため、スプラッシュ画面で削除する
        * スプラッシュ画面から登録画面への導線を引きたいが、これは将来的に考える

## 画面

| ID   | 画面名 | 備考 |
|:-----|:-----|:-----|
| A-01  | スプラッシュ | |
| A-02  | ログイン  | Firebaseへの匿名ログイン |
| A-03  | 通知許諾  | |
| B-01  | ホーム    | TODO一覧 |
| C-01  | TODO登録  | |
| S-01  | 設定  | |
| S-02  | ライセンス  | LicensePlistViewController で表示 |
| S-03  | 問い合わせ  | Googleフォームを SFSafariViewController で表示 |

## ユースケース

| ID   | ユースケース名 | 備考 |
|:-----|:-----|:-----|
| BL-A01  | lunch  | |
| BL-A01-1  | check login  | |
| BL-1-2  | check version | |
| BL-1-4  | check editing  | |
| BL-B01  | fetch todo list  | sort option |
| BL-B02  | TODOアイテムの削除 | |
| BL-C01  | TODOアイテムの登録・編集開始  | editing のレコードを作成する |
| BL-C02  | TODOアイテムの登録・編集完了  | Firestoreへの同期 |
| BL-C03  | TODOアイテムの編集キャンセル  | editing のレコードを削除する |
| BL-S01 | settings  | |
| [BL-S02](./BL-S02.md)  | ログアウト  | |
| [BL-Z01](./BL-Z01.md)  | データの同期 | Firestore へ ready のレコードの同期を実施する |
| BL-Z02 | ネットワーク接続状態のチェック |  |
