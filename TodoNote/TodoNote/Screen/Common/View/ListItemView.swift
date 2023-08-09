//
//  ListItemView.swift
//
//  Created by KENJIWADA on 2022/03/20.
//  Copyright © 2022 KENJI WADA. All rights reserved.
//

import SwiftUI

struct ListItemView<Content>: View where Content: View {
    let content: () -> Content

    let action: (() -> Void)?

    let hasArrow: Bool

    init(action: (() -> Void)?, hasArrow: Bool, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.hasArrow = hasArrow
        self.action = action
    }

    var body: some View {
        ZStack {
            if let action = action {
                Button(action: action) {
                    EmptyView()
                }
            }

            HStack(spacing: 0) {
                content()

                Spacer(minLength: 0)

                if hasArrow {
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color(UIColor.tertiaryLabel))
                        .font(.system(size: 14, weight: .semibold))
                        .padding(.leading, 8)
                }
            }
        }
    }

    // MARK: -

    private func onClickItem() {
        action?()
    }
}

struct ListItemView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                ListItemView(action: nil, hasArrow: true) {
                    Text("テキストタイトル")
                }

                ListItemView(action: nil, hasArrow: false) {
                    Text("テキストタイトル")
                }
            }
        }
    }
}
