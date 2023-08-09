//
//  SettingsView.swift
//
//  Created by KENJIWADA on 2023/03/16.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.viewController) private var viewControllerHolder: ViewControllerHolder
    private var viewController: UIViewController? {
        viewControllerHolder.value
    }

    @ObservedObject private var model = SettingsViewModel()

    var body: some View {
        List {
            Section {
                // お問合せ
                SettingsListItemView(
                    image: Image(systemName: "pencil.circle"),
                    title: R.string.localizable.settings_cell_feedback.text,
                    description: R.string.localizable.settings_cell_feedback_desc.text
                ) {
                    SettingsViewRouter.moveFeedback(from: viewController)
                }
            }

            // その他
            Section {
                // プラポリ
                SettingsListItemView(
                    image: nil,
                    title: R.string.localizable.settings_about_cell_privacy_policy.text,
                    description: nil
                ) {
                    SettingsViewRouter.movePrivacyPolicy(from: viewController)
                }

                // 利用規約
                SettingsListItemView(
                    image: nil,
                    title: R.string.localizable.settings_about_cell_user_policy.text,
                    description: nil
                ) {
                    SettingsViewRouter.moveUserPolicy(from: viewController)
                }

                // ライセンス
                SettingsListItemView(
                    image: nil,
                    title: R.string.localizable.settings_about_cell_licences.text,
                    description: nil
                ) {
                    SettingsViewRouter.moveLicences(from: viewController)
                }

                // 開発者
                SettingsListItemView(
                    image: Image(systemName: "person.circle"),
                    title: R.string.localizable.settings_about_cell_company.text,
                    description: R.string.localizable.settings_about_cell_company_desc.text
                ) {
                    SettingsViewRouter.moveDeveloper(from: viewController)
                }

            } header: {
                R.string.localizable.settings_section_other.text
            }

            Section {
                Button(action: {
                    model.onClickSignOutButton(from: viewController)
                }) {
                    R.string.localizable.logout.text
                        .foregroundColor(Color.red)
                        .font(.system(size: 15, weight: .bold))
                        .frame(maxWidth: .infinity)
                }
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
        .navigationTitle(R.string.localizable.settings_title.text)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            model.onAppear(from: viewController)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: onClickCloseButton) {
                    R.string.localizable.close.text
                }
            }
        }
        .alert(item: $model.alertItem) { $0.alert }
        .actionSheet(item: $model.actionSheetItem) { $0.sheet }
    }

    private func onClickCloseButton() {
        viewController?.dismiss(animated: true)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
