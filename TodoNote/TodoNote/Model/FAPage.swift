//
//  FAPage.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/07.
//

import Foundation

enum FAPage: String {
    case splash = "スプラッシュ"
    case home = "ホーム"
    case editTodo = "タスク編集"

    // 設定
    case settings = "設定"
    case settingsFeedback = "設定/お問い合わせ"
    case settingsUserPolicy = "設定/利用規約"
    case settingsPrivacyPolicy = "設定/プライバシーポリシー"
    case settingsPublisher = "設定/運営会社"
    case settingsLicense = "設定/ライセンス情報"
}

extension FAPage {
    func send() {}
}
