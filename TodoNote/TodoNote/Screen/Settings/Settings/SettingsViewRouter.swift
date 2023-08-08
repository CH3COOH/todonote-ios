//
//  SettingsViewRouter.swift
//  Peacemaker
//
//  Created by KENJIWADA on 2023/03/18.
//

import LicensePlistViewController
import SafariServices
import SwiftUI

struct SettingsViewRouter {
    static func movePrivacyPolicy(from _: UIViewController?) {
//        guard let url = AppConstValues.urlPrivacyPolicy else {
//            return
//        }
//
//        let vc = SFSafariViewController(url: url)
//        vc.hidesBottomBarWhenPushed = true
//        viewController?.present(vc, animated: true)
    }

    static func moveTermOfService(from _: UIViewController?) {
//        guard let url = AppConstValues.urlTermOfService else {
//            return
//        }
//
//        let vc = SFSafariViewController(url: url)
//        vc.hidesBottomBarWhenPushed = true
//        viewController?.present(vc, animated: true)
    }

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

//    /// お問合せ
//    static func moveFeedback(from viewController: UIViewController?) {
//        let vc = AAMFeedbackViewController(theIssues: nil)
//        vc.toRecipients = [R.string.localizable.feedback_mail_to()]
//        vc.footerText = R.string.localizable.feedback_footer()
//        let nc = UINavigationController(rootViewController: vc)
//        nc.isModalInPresentation = true
//        viewController?.present(nc, animated: true) {
//            FAPage.settingsRequest.send()
//        }
//    }
//
//    /// 不具合の報告
//    static func moveBugReport(from viewController: UIViewController?, fromReview: Bool) {
//        let vc = AAMFeedbackViewController(theIssues: nil)
//        vc.setTopic(topic: "feedback_topics_bug_report")
//        vc.toRecipients = [R.string.localizable.feedback_mail_to()]
//        vc.footerText = R.string.localizable.feedback_footer()
//        let nc = UINavigationController(rootViewController: vc)
//        nc.isModalInPresentation = true
//        viewController?.present(nc, animated: true) {
//            if fromReview {
//                FAPage.settingsReportBugFromReview.send()
//            } else {
//                FAPage.settingsReportBugFromMenu.send()
//            }
//        }
//    }

//    /// レビューを書く
//    static func moveStoreReview(from _: UIViewController?) {
//        guard let url = AppConstValues.urlStore else {
//            return
//        }
//        UIApplication.shared.open(url, options: [:]) { _ in
//            FAPage.settingsWriteReview.send()
//        }
//    }

    /// Four Cropper
    static func moveAppStoreFourCropper(from _: UIViewController?) {
        guard let url = URL(string: "https://apps.apple.com/jp/app/id1516030921") else {
            return
        }
        UIApplication.shared.open(url, options: [:]) { _ in
            // FAPage.settingsWriteReview.send()
        }
    }

    /// ptcgnote
    static func moveAppStorePtcgnote(from _: UIViewController?) {
        guard let url = URL(string: "https://apps.apple.com/jp/app/id1460085667") else {
            return
        }
        UIApplication.shared.open(url, options: [:]) { _ in
            // FAPage.settingsWriteReview.send()
        }
    }
}
