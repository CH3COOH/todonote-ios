# TODOアイテムの新規作成/編集時の考え方

## 新規作成時

* 編集画面を開いたとき
    * 空のレコードを作成する。ステータスは `editing` とする
* 保存ボタンを押したとき
    1. ステータスを `editing` から `ready` へ変更
    2. サーバーへ同期後は `complete` へ変更する
* キャンセルボタンを押したとき
   * `editing` のレコードを削除する

## 編集時

* 編集画面を開いたとき
    * `ready` または `complete` の既存のレコードをコピーし、ステータスを `editing` とする
* 保存ボタンを押したとき
    1. `ready` または `complete` の既存のレコードを削除する
    2. ステータスを `editing` から `ready` へ変更
    3. サーバーへ同期後は `complete` へ変更する
* キャンセルボタンを押したとき
   * `editing` のレコードを削除する

## 編集時のサーバー同期までの流れ

編集時のサーバー同期までの流れを図に示す。

### 前提： status=complete のレコードがある状態

<img width="399" alt="database-01" src="https://github.com/CH3COOH/todonote-ios/assets/137952/dc9d3dd4-daf7-4f1a-aa93-4b8d3f5b3ce8">

### ステップ1：既存のレコードをコピーし、ステータスを editing とする

<img width="399" alt="database-02" src="https://github.com/CH3COOH/todonote-ios/assets/137952/2843f6f1-f807-4308-a072-fb0e4f2f571b">

### ステップ2：既存のレコードを削除して、ステータスを editing から ready へ変更する

<img width="399" alt="database-03" src="https://github.com/CH3COOH/todonote-ios/assets/137952/32d6406d-3cd1-45ec-886f-97f86c96b3ec">

### ステップ3： Firebase への同期後に、ステータスを ready から complete とする

<img width="399" alt="database-04" src="https://github.com/CH3COOH/todonote-ios/assets/137952/5323a1ca-a71d-42d4-8d39-63ae8c7da35e">


