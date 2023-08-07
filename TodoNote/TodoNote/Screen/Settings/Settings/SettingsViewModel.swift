//
//  SettingsViewModel.swift
//  Peacemaker
//
//  Created by KENJIWADA on 2023/03/18.
//

import SwiftUI

class SettingsViewModel: ObservableObject {
    @Published var appVersion: String

    @Published var isDebug: Bool

    @Published var reportActionSheetItem: ActionSheetItem?

    init() {
        // アプリバージョンの取得
        if let version = Bundle.main.infoDictionary?["CFBundleVersion"] as? String,
           let shortVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        {
            appVersion = R.string.localizable.settings_copy_right(shortVersion, version)
        } else {
            appVersion = R.string.localizable.settings_copy_right("---", "---")
        }
//
//        isDebug = UIDevice.isSimulator

        isDebug = true
    }

    // MARK: -

    func update() {}

    /// レビューを書く
    func onClickWriteReviewButton(from _: UIViewController?) {
        reportActionSheetItem = .init(
            sheet: ActionSheet(
                title: R.string.localizable.settings_bug_report_desc.text,
                message: nil,
                buttons: [
                    .default(R.string.localizable.settings_report_bugs.text) {
                        // SettingsViewRouter.moveBugReport(from: viewController, fromReview: true)
                    },
                    .default(R.string.localizable.settings_write_review.text) {
                        // SettingsViewRouter.moveStoreReview(from: viewController)
                    },
                    .cancel(),
                ]
            )
        )
    }

    // MARK: -
}
