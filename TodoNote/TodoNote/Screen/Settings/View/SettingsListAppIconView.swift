//
//  SettingsListAppIconView.swift
//  Peacemaker
//
//  Created by KENJIWADA on 2023/04/02.
//

import SwiftUI

struct SettingsListAppIconView: View {
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
                            .cornerRadius(4)
                            .scaledToFill()
                            .padding(.top, 8)

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

struct SettingsListAppIconView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                SettingsListItemView(
                    image: R.image.crown_1.image.resizable(),
                    title: Text("おしらせ"),
                    description: Text("アプリの更新をお知らせします。"),
                    action: nil
                )

                SettingsListItemView(
                    image: R.image.diamond_1.image.resizable(),
                    title: Text("おしらせ"),
                    description: Text("アプリの更新をお知らせします。"),
                    action: nil
                )

                SettingsListItemView(
                    image: R.image.diamond_2.image.resizable(),
                    title: Text("おしらせ"),
                    description: Text("アプリの更新をお知らせします。"),
                    action: nil
                )

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
