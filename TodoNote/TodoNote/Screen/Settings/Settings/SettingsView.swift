//
//  SettingsView.swift
//  Peacemaker
//
//  Created by KENJIWADA on 2023/03/16.
//

import SafariServices
import SwiftUI

struct SettingsView: View {
    @Environment(\.viewController) private var viewControllerHolder: ViewControllerHolder
    private var viewController: UIViewController? {
        viewControllerHolder.value
    }

    @ObservedObject private var model = SettingsViewModel()

    var body: some View {
        List {
//            // アプリ内設定
//            Section {
//
//            } header: {
//                R.string.localizable.settings_section_app.text
//            }

//            // ストア
//            Section {
//                SettingsListItemView(
//                    image: premiumImage,
//                    imageColor: R.color.accentColor.color,
//                    title: R.string.localizable.settings_cell_store.text,
//                    description: R.string.localizable.settings_cell_store_desc.text
//                ) {
//                    SettingsViewRouter.moveStore(from: viewController)
//                }
//            }

            // その他
            Section {
//                // お問合せ
//                SettingsListItemView(
//                    image: Image(systemName: "pencil.circle"),
//                    title: R.string.localizable.settings_cell_feedback.text,
//                    description: R.string.localizable.settings_cell_feedback_desc.text
//                ) {
//                    SettingsViewRouter.moveFeedback(from: viewController)
//                }
//
//                // 不具合報告
//                SettingsListItemView(
//                    image: Image(systemName: "ant.circle"),
//                    title: R.string.localizable.settings_cell_bug_report.text,
//                    description: R.string.localizable.settings_cell_bug_report_desc.text
//                ) {
//                    SettingsViewRouter.moveBugReport(from: viewController, fromReview: false)
//                }
//
//                // レビューを書く
//                SettingsListItemView(
//                    image: Image(systemName: "star.circle"),
//                    title: R.string.localizable.settings_cell_write_review.text,
//                    description: R.string.localizable.settings_cell_write_review_desc.text
//                ) {
//                    model.onClickWriteReviewButton(from: viewController)
//                }
//                .actionSheet(item: $model.reportActionSheetItem) { $0.sheet }
//
//                // このアプリについて
//                SettingsListItemView(
//                    image: Image(systemName: "person.circle"),
//                    title: R.string.localizable.settings_cell_about.text,
//                    description: R.string.localizable.settings_cell_about_desc.text
//                ) {
//                    SettingsViewRouter.moveAbout(from: viewController)
//                }

                // このアプリについて
                SettingsListItemView(
                    image: Image(systemName: "person.circle"),
                    title: R.string.localizable.settings_about_cell_licences.text,
                    description: nil
                ) {
                    SettingsViewRouter.moveLicences(from: viewController)
                }
            } header: {
                Text("その他")
//                R.string.localizable.settings_section_other.text
            }

            HStack {
                VStack(alignment: .center) {
                    Text(model.appVersion)
                        .font(.system(size: 15, weight: .regular))
                        .multilineTextAlignment(.center)
                }
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
            }
        }
        .listStyle(.insetGrouped)
//        .navigationTitle(R.string.localizable.settings_title.text)
        .navigationTitle(Text("設定"))
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            model.update()
            FAPage.settings.send()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    viewController?.dismiss(animated: true)
                }) {
                    Text("閉じる")
//                    R.string.localizable.close.text
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
