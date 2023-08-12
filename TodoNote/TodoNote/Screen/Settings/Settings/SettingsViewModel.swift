//
//  SettingsViewModel.swift
//
//  Created by KENJIWADA on 2023/03/18.
//

import SwiftUI

class SettingsViewModel: BaseViewModel {
    @Published var appVersion: String

    private let signOutUseCase = SignOutUseCase()

    override init() {
        // アプリバージョンの取得
        if let version = Bundle.main.infoDictionary?["CFBundleVersion"] as? String,
           let shortVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        {
            appVersion = R.string.localizable.settings_copy_right(shortVersion, version)
        } else {
            appVersion = R.string.localizable.settings_copy_right("---", "---")
        }
        super.init()
    }

    // MARK: -

    func onAppear(from _: UIViewController?) {
        FAPage.settings.send()
    }

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
        Task {
            let result = await signOutUseCase.execute(.init())
            switch result {
            case .success:
                await moveLoginScreen(from: viewController)
            case let .failed(error):
                await show(error: error)
            }
        }
    }

    @MainActor
    private func moveLoginScreen(from viewController: UIViewController?) {
        viewController?.dismiss(animated: false) {
            SceneDelegate.shared?.rootViewController.switchToLoginScreen()
        }
    }
}
