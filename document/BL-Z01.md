# BL-Z01 データの同期

1. ステータスが `ready` のレコードを取得する
    * がなければ処理は終了
2. Firestore へデータの同期
    * finished が false の場合、FirestoreのDocument を作成/更新する
    * finished が true の場合、FirestoreのDocument を削除する
3. ステータスの変更
    * finished が false の場合、レコードを削除する
    * finished が true の場合、ステータスを complete に変更する