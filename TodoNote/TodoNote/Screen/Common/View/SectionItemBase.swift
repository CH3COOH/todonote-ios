//
//  SectionItemBase.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/10.
//

import SwiftUI

struct SectionItemBase<Content>: View where Content: View {
    let title: String

    let content: () -> Content

    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(R.color.textMain.color)

            Spacer(minLength: 0)

            content()
        }
//        .padding(.init(top: 24, leading: 26, bottom: 6, trailing: 10))
        .listRowSeparator(.hidden)
        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
}

struct SectionItemBase_Previews: PreviewProvider {
    static var previews: some View {
        List {
            SectionItemBase(title: "タイトル") {
                EmptyView()
            }
        }
        .listStyle(.plain)
    }
}
