# BL-Z01 TODOアイテムのアップロード

## 入力

* なし

## 出力

* 成功 (success)
* 失敗 (failed)

## 処理

1. ステータスが "ready" のTODOアイテムをローカルから取得する。
2. アイテムがなければ成功を返して終了する。
3. ネットワーク接続が利用可能かを確認する。
    * 接続可能な場合は、次のステップに進む。
    * 接続不可能な場合は、成功を返して終了する。
4. 各TODOアイテムについて以下の処理を行う:
    * アイテムが完了している場合は、Firestoreから該当するアイテムを削除する。
    * アイテムが未完了の場合は、Firestoreにアイテムを追加または更新する。
5. Firestoreとの同期後、ローカルデータのステータスを `complete` に更新する。
6. 各TODOアイテムについて以下の処理を行う:
    * アイテムが完了している場合は、ローカルから該当するアイテムを削除する。
    * アイテムが未完了の場合は、そのアイテムのステータスを更新する。
