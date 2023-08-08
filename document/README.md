# Documents

以下は、TodoNote の開発資料である

## コンセプト

* オフラインでも利用可能な TODO 管理アプリ
* ユーザーにネットワーク状態を意識させない

## 画面遷移図

<img width="749" alt="screen-transition" src="https://github.com/CH3COOH/todonote-ios/assets/137952/dbdc0ac1-96f2-4873-ade5-7f9c9cbc7da1">

## TODOアイテムについて

### TODOアイテムの同期

* TODOアイテムは「editing」「ready」「complete」の3つのステータスを持つ
    * `editing` は 編集中
    * `ready` は、準備完了
    * `complete` は、サーバーへの同期済み
* ステータスが `ready` のTODOアイテムは、TODO登録/編集完了時・アプリ起動時に サーバーへ同期する。オフラインでもエラーを表示しない
* ステータスが `editing` のTODOアイテムは、TODO登録画面以外では存在させない
    * 登録画面上でアプリを終了させた場合、`editing`のレコードが残るため、スプラッシュ画面で削除する
    * スプラッシュ画面から登録画面への導線を引きたいが、これは将来的に考える

### TODOアイテムの登録/編集処理

* TODOアイテムの新規登録時
    * 
* 既存の TODO アイテムの編集時
    * `ready` または `complete` の既存のレコードをコピーし、ステータスを `editing` へ変更する
    * Save ボタンの押下で、既存のレコードを削除し、ステータスを `editing` から `ready` へ変更。サーバーへ同期後は `complete` へ変更する
    * Cancel ボタンの押下で、`editing` のレコードを削除する

## 画面・ユースケース

| ID   | 画面名 | 備考 |
|:-----|:-----|:-----|
| A-1  | スプラッシュ | |
| A-2  | ログイン  | Firebaseへの匿名ログイン |
| A-3  | 通知許諾  | |
| B-1  | ホーム    | TODO一覧 |
| C-1  | TODO登録  | |
| S-1  | 設定  | |
| S-2  | ライセンス  | LicensePlistViewController で表示 |
| S-3  | 問い合わせ  | Googleフォームを SFSafariViewController で表示 |


| ID   | ユースケース名 | 備考 |
|:-----|:-----|:-----|
| UA-1  | lunch  | |
| UA-1-1  | check login  | |
| U-1-2  | check version | |
| U-1-3  | sync ready  | |
| U-1-4  | check editing  | |
| U-2  | fetch todo list  | sort option |
| U-3  | update todo  | |
| US-1  | settings  | |
| US-2  | logout  | |
