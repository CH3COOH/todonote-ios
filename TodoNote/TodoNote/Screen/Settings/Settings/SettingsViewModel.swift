//
//  SettingsViewModel.swift
//
//  Created by KENJIWADA on 2023/03/18.
//

import FirebaseAuth
import SwiftUI

class SettingsViewModel: ObservableObject {
    @Published var appVersion: String

    @Published var actionSheetItem: ActionSheetItem?

    @Published var alertItem: AlertItem?

    init() {
        // アプリバージョンの取得
        if let version = Bundle.main.infoDictionary?["CFBundleVersion"] as? String,
           let shortVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        {
            appVersion = R.string.localizable.settings_copy_right(shortVersion, version)
        } else {
            appVersion = R.string.localizable.settings_copy_right("---", "---")
        }
    }

    // MARK: -

    func update() {}

    func onClickSignOutButton(from viewController: UIViewController?) {
        actionSheetItem = ActionSheetItem(
            sheet: ActionSheet(
                title: R.string.localizable.settings_alert_logout_title.text,
                message: R.string.localizable.settings_alert_logout_message.text,
                buttons: [
                    .destructive(R.string.localizable.logout.text) {
                        self.logout(viewController: viewController)
                    },
                    .cancel(),
                ]
            )
        )
    }

    // MARK: -

    private func logout(viewController: UIViewController?) {
        do {
            try Auth.auth().signOut()

            viewController?.dismiss(animated: false) {
                SceneDelegate.shared?.rootViewController.switchToLoginScreen()
            }
        } catch {
            // TODO: エラー処理
        }
    }
}
