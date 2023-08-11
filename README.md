# TodoNote for iOS

TodoNote は、iOS用TODO管理アプリである。

## ビルド方法

```
cd /PATH/todonote-ios/TodoNote
bundle install
bundle exec pod install
```

* `GoogleService-Info.plist` はプロジェクトには含まれていないため、ビルド前に追加すること。

## 開発

開発向けのドキュメントは [document](./document/README.md) に置いている。

### 開発環境

* macOS 13.4.1 (c)
* Xcode 14.3.1

### 構成

* UIの実装: SwiftUI (View) + UIKit (Navigation)
* アーキテクチャ: Clean Architecture 
* パッケージマネージャ: CocoaPods
* バックエンド: Firestore