//
//  SettingsListItemView.swift
//
//  Created by KENJIWADA on 2022/03/20.
//  Copyright © 2022 KENJI WADA. All rights reserved.
//

import SwiftUI

struct SettingsListItemView: View {
    let image: Image?

    var imageColor: Color = .init(UIColor.secondaryLabel)

    let title: Text

    let description: Text?

    var descriptionColor: Color = .init(UIColor.secondaryLabel)

    var descriptionFont: Font = .system(size: 15, weight: .light)

    let action: (() -> Void)?

    var body: some View {
        ListItemView(action: action, hasArrow: true) {
            HStack(spacing: 16) {
                if let image = image {
                    VStack {
                        image
                            .font(.system(size: 28))
                            .foregroundColor(imageColor)
                            .frame(width: 28, height: 28)
                            .cornerRadius(14)
                            .scaledToFill()
                            .padding(.top, description != nil ? 8 : 12)
//                            .overlay {
//                                RoundedRectangle(cornerRadius: 14).stroke(Color(UIColor.tertiaryLabel), lineWidth: 1)
//                            }

                        Spacer(minLength: 0)
                    }
                    .frame(width: 32)
                }

                VStack(alignment: .leading, spacing: 4) {
                    title
                        .font(.system(size: 17, weight: .regular))
                        .foregroundColor(Color(UIColor.label))

                    if let desc = description {
                        desc
                            .font(descriptionFont)
                            .foregroundColor(descriptionColor)
                    }
                }
            }
            .padding(.vertical, 4)
        }
    }
}

struct SettingsListItemView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
//                SettingsListItemView(
//                    image: R.image.crown_1.image.resizable(),
//                    title: Text("おしらせ"),
//                    description: Text("アプリの更新をお知らせします。"),
//                    action: nil
//                )
//
//                SettingsListItemView(
//                    image: R.image.diamond_1.image.resizable(),
//                    title: Text("おしらせ"),
//                    description: Text("アプリの更新をお知らせします。"),
//                    action: nil
//                )
//
//                SettingsListItemView(
//                    image: R.image.diamond_2.image.resizable(),
//                    title: Text("おしらせ"),
//                    description: Text("アプリの更新をお知らせします。"),
//                    action: nil
//                )

                SettingsListItemView(
                    image: Image(systemName: "info.circle"),
                    title: Text("おしらせ"),
                    description: Text("アプリの更新をお知らせします。"),
                    action: nil
                )
            }
        }
    }
}
