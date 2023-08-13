# TODOアイテムの新規作成/編集時の考え方

ユーザーに対して、データをローカルで持っているのか、バックエンドに保存しているのか、意識させないようにする

## ステーテス

TODOアイテムは「editing」「ready」「complete」の3つのステータスを持つ。それぞれの状態は以下の通りである。

* `editing` は 編集中
* `ready` は、準備完了
* `complete` は、バックエンドへの同期済み

## 新規アイテムの登録

### 開始時

1. 空のレコードを作成する。ステータスは `editing` とする

### 保存時

1. ステータスを `editing` から `ready` へ変更
2. バックエンドへ同期
3. `complete` へ変更する

### キャンセル時

1. `editing` のレコードを削除する

## 既存アイテムの編集

### 開始時

* `ready` または `complete` の既存のレコードをコピーし、ステータスを `editing` とする

### 保存時

1. `ready` または `complete` の既存のレコードを削除する
2. ステータスを `editing` から `ready` へ変更
3. バックエンドへ同期
4. ステータスを `complete` へ変更する

### キャンセル時

1. `editing` のレコードを削除する

## 編集時のサーバー同期までの流れ

編集時のサーバー同期までの流れを図に示す。該当するユースケースは [BL-C02 TODOアイテムの登録・編集完了](./BL-C02.md) である。

### 前提： status=complete のレコードがある状態

| todo_id | status   | title       | 
|:--------|:---------|:------------|
| 1       | complete | キャベツを買う |

### ステップ1：既存のレコードをコピーし、ステータスを editing とする

| todo_id | status   | title       | 
|:--------|:---------|:------------|
| 1       | editing  | キャベツを買う |
| 1       | complete | キャベツを買う |

### ステップ2：ユーザーの入力ごとにレコードを更新する

たとえば、タイトルを「キャベツを買う」から「りんごへ買う」に変更する。

| todo_id | status   | title       | 
|:--------|:---------|:------------|
| 1       | editing  | りんごを買う |
| 1       | complete | キャベツを買う |

### ステップ3：既存のレコードを削除して、ステータスを editing から ready へ変更する

| todo_id | status   | title       | 
|:--------|:---------|:------------|
| 1       | ready    | りんごを買う |

### ステップ4：バックエンドへの同期

* バックエンドへ保存する
    * 成功時：次のステップへ
    * 失敗時：ステータス `ready` のまま処理を終了する

### ステップ5：ステータスを ready から complete とする

| todo_id | status   | title       | 
|:--------|:---------|:------------|
| 1       | complete | りんごを買う |

## よくある質問と答え

### アイテムの編集中にアプリをkillされた場合、editing のレコードが残ってしまうのでは？

答え：残ります

そのためアプリ起動時に `editing` のレコードを一括削除する処理を実装している。

将来的には、`editing` のレコードが残っていれば、スプラッシュ画面で「前回編集中のアイテムがある。続けて編集するか？」などのダイアログを表示してあげたい。