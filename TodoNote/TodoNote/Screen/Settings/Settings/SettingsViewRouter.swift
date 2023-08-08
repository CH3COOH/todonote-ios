//
//  SettingsViewRouter.swift
//
//  Created by KENJIWADA on 2023/03/18.
//

import LicensePlistViewController
import SafariServices
import SwiftUI

struct SettingsViewRouter {
    /// ストア
    static func moveStore(from _: UIViewController?) {
//        let vc = UIViewController.hostingController {
//            StoreView(
//                fromInformation: false
//            )
//        }
//        vc.hidesBottomBarWhenPushed = true
//        viewController?.navigationController?.pushViewController(vc, animated: true)
    }

    /// このアプリについて
    static func moveAbout(from _: UIViewController?) {
//        let vc = UIViewController.hostingController {
//            AboutSettingsView()
//        }
//        vc.hidesBottomBarWhenPushed = true
//        viewController?.navigationController?.pushViewController(vc, animated: true)
    }

    /// ライセンス
    static func moveLicences(from viewController: UIViewController?) {
        let vc = LicensePlistViewController(tableViewStyle: .insetGrouped)
        vc.hidesBottomBarWhenPushed = true
        viewController?.navigationController?.pushViewController(vc, animated: true)
//        FAPage.settingsLicense.send()
    }

    /// お問合せ
    static func moveFeedback(from viewController: UIViewController?) {
        guard let url = URL(string: AppConstValues.urlFeedback) else {
            return
        }
        SafariUtil.show(
            from: viewController,
            url: url,
            page: FAPage.settingsFeedback
        )
    }

    /// 利用規約
    static func moveUserPolicy(from viewController: UIViewController?) {
        guard let url = URL(string: AppConstValues.urlUserPolicy) else {
            return
        }
        SafariUtil.show(
            from: viewController,
            url: url,
            page: FAPage.settingsUserPolicy
        )
    }

    /// プラポリ
    static func movePrivacyPolicy(from viewController: UIViewController?) {
        guard let url = URL(string: AppConstValues.urlPrivacyPolicy) else {
            return
        }
        SafariUtil.show(
            from: viewController,
            url: url,
            page: FAPage.settingsPrivacyPolicy
        )
    }

    /// 開発者
    static func moveDeveloper(from viewController: UIViewController?) {
        guard let url = URL(string: AppConstValues.urlBlog) else {
            return
        }
        SafariUtil.show(
            from: viewController,
            url: url,
            page: FAPage.settingsPublisher
        )
    }
}
