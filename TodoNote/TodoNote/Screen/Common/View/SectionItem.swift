//
//  SectionItem.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/10.
//

import SwiftUI

struct SectionItem: View {
    let title: String

    var body: some View {
        SectionItemBase(title: title) {
            EmptyView()
        }
    }
}

struct SectionItem_Previews: PreviewProvider {
    static var previews: some View {
        SectionItem(title: "タイトル")
    }
}
