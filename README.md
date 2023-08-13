[![Build Status](https://app.bitrise.io/app/80fabd50-5db4-48ac-8357-21cbc43d7cb9/status.svg?token=-E0kWr3snOcU4eLFaYi9Vw&branch=master)](https://app.bitrise.io/app/80fabd50-5db4-48ac-8357-21cbc43d7cb9)

# TodoNote for iOS

TodoNote は、iOS向けTODO管理アプリです。

![fk-PAUI8193_TP_V](https://github.com/CH3COOH/todonote-ios/assets/137952/d06483a2-846e-44ae-9713-88cf6aa2ddc2)

## ビルド方法

```
cd /PATH/todonote-ios/TodoNote
bundle install
bundle exec pod install
```

* `GoogleService-Info.plist` はプロジェクトには含まれていない。ビルド前に追加すること。

## Development

開発向けのドキュメントは [document](./document/README.md)ディレクトリに置いている。

### 開発環境

* macOS 13.4.1 (c)
* Xcode 14.3.1

### 構成

* UIの実装: SwiftUI (View) + UIKit (Navigation)
* アーキテクチャ: Clean Architecture 
* パッケージマネージャ: CocoaPods
* バックエンド: Cloud Firestore
* CI: Bitrise
