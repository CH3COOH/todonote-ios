//
//  TodoItemView.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/08.
//

import SwiftUI

struct TodoItemView: View {
    let item: Todo

    @State private var checked = false

    var body: some View {
        HStack {
            Button(action: { checked.toggle() }) {
                if checked {
                    Image(systemName: "checkmark.square")
                        .resizable()
                        .frame(width: 44, height: 44)
                        .scaledToFit()
                } else {
                    Image(systemName: "square")
                        .resizable()
                        .frame(width: 44, height: 44)
                        .scaledToFit()
                }
            }
            .buttonStyle(.plain)
            VStack {
                Text(item.title)
                if !item.body.isEmpty {
                    Text(item.body)
                }
            }
        }
    }
}

// struct TodoItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        TodoItemView()
//    }
// }
