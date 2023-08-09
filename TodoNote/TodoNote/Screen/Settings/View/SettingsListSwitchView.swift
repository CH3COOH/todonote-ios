//
//  SettingsListSwitchView.swift
//
//  Created by KENJIWADA on 2022/06/19.
//  Copyright © 2022 KENJI WADA. All rights reserved.
//

import SwiftUI

struct SettingsListSwitchView: View {
    let image: Image?

    var imageColor: Color = .init(UIColor.secondaryLabel)

    let title: Text

    var titleFont: Font = .system(size: 16, weight: .regular)

    let description: Text?

    var descriptionColor: Color = .init(UIColor.secondaryLabel)

    var descriptionFont: Font = .system(size: 15, weight: .light)

    @Binding var isEnable: Bool

    let action: (() -> Void)?

    init(
        image: Image? = nil,
        imageColor: Color = Color(UIColor.secondaryLabel),
        title: Text,
        titleFont: Font = .system(size: 16, weight: .regular),
        description: Text? = nil,
        descriptionColor: Color = Color(UIColor.secondaryLabel),
        descriptionFont: Font = .system(size: 15, weight: .light),
        isEnable: Binding<Bool>,
        action: (() -> Void)? = nil
    ) {
        self.image = image
        self.imageColor = imageColor
        self.title = title
        self.titleFont = titleFont
        self.description = description
        self.descriptionColor = descriptionColor
        self.descriptionFont = descriptionFont
        _isEnable = isEnable
        self.action = action
    }

    var body: some View {
        ListItemView(action: action, hasArrow: false) {
            HStack(spacing: 8) {
                if let image = image {
                    VStack {
                        image
                            .font(.system(size: 28))
                            .foregroundColor(imageColor)

                        Spacer(minLength: 0)
                    }
                    .frame(width: 32)
                    .padding(.trailing, 8)
                }

                VStack(alignment: .leading, spacing: 4) {
                    title
                        .font(titleFont)
                        .foregroundColor(Color(UIColor.label))

                    if let desc = description {
                        desc
                            .font(descriptionFont)
                            .foregroundColor(descriptionColor)
                    }
                }
                Spacer(minLength: 0)
                Toggle("", isOn: $isEnable)
                    .labelsHidden()
            }
            .padding(.vertical, 4)
        }
    }
}

struct SettingsListSwitchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                SettingsListSwitchView(
                    image: Image(systemName: "info.circle"),
                    title: Text("おしらせ"),
                    description: Text("アプリの更新をお知らせします。"),
                    isEnable: .constant(false),
                    action: nil
                )
            }
        }
    }
}
