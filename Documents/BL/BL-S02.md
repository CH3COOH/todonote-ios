# BL-S02 ログアウト

## 入力

* なし

## 出力

* 成功 (success)
* 失敗 (failed)

## 処理

1. ステータスが `ready` のレコードをバックエンドへアップロードする
    * 「[BL-Z01 TODOアイテムのアップロード](./BL-Z01.md)」を実行する
    * アップロードが成功した場合: サインアウトする
    * アップロードが失敗した場合: エラーを返して終了する
2. サインアウトする
    * サインアウトが失敗した場合: エラーを返して終了する
3. すべての未送信の通知リクエストと配信済みの通知を削除する。
4. ローカルデータを全て削除する。
    * 削除に成功した場合: 成功を返して終了する。
    * 削除に失敗した場合: エラーをログに出力し、成功を返して終了する。
