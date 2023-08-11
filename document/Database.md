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

<img width="399" alt="database-01" src="https://github.com/CH3COOH/todonote-ios/assets/137952/dc9d3dd4-daf7-4f1a-aa93-4b8d3f5b3ce8">

| todo_id | status   | title       | 
|:--------|:---------|:------------|
| 1       | complete | キャベツを買う |

### ステップ1：既存のレコードをコピーし、ステータスを editing とする

<img width="399" alt="database-02" src="https://github.com/CH3COOH/todonote-ios/assets/137952/2843f6f1-f807-4308-a072-fb0e4f2f571b">

| todo_id | status   | title       | 
|:--------|:---------|:------------|
| 1       | editing | りんごを買う |
| 1       | complete | キャベツを買う |

### ステップ2：既存のレコードを削除して、ステータスを editing から ready へ変更する

<img width="399" alt="database-03" src="https://github.com/CH3COOH/todonote-ios/assets/137952/32d6406d-3cd1-45ec-886f-97f86c96b3ec">

| todo_id | status   | title       | 
|:--------|:---------|:------------|
| 1       | ready | りんごを買う |

### ステップ3：バックエンドへの同期

* バックエンドへの保存に失敗した場合は、ステータス `ready` のまま処理を終了する

### ステップ4：ステータスを ready から complete とする

<img width="399" alt="database-04" src="https://github.com/CH3COOH/todonote-ios/assets/137952/5323a1ca-a71d-42d4-8d39-63ae8c7da35e">

| todo_id | status   | title       | 
|:--------|:---------|:------------|
| 1       | complete | りんごを買う |

## よくある質問と答え

### アイテムの編集中にアプリをkillされた場合、editing のレコードが残ってしまうのでは？

答え：残ります

そのためアプリ起動時に `editing` のレコードを一括削除する処理を実装している。本来は、`editing` のレコードが残っていれば、スプラッシュ画面で「前回編集中のアイテムがある。続けて編集するか？」などのダイアログを表示してあげたいが、将来的に考える。