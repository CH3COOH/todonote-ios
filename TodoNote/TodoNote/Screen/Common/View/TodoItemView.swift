//
//  TodoItemView.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/08.
//

import SwiftUI

struct TodoItemView: View {
    let item: Todo

    let doneAction: () -> Void

    let editAction: () -> Void

    var body: some View {
        HStack {
            Button(action: doneAction) {
//                if checked {
//                    Image(systemName: "checkmark.square")
//                        .resizable()
//                        .frame(width: 44, height: 44)
//                        .scaledToFit()
//                } else {
                Image(systemName: "square")
                    .resizable()
                    .frame(width: 44, height: 44)
                    .scaledToFit()
//                }
            }
            .buttonStyle(.plain)

            VStack {
                Text(item.title)
                if !item.description.isEmpty {
                    Text(item.description)
                }
            }

            Button(action: editAction) {
                Image(systemName: "square.and.pencil.circle")
                    .resizable()
                    .frame(width: 44, height: 44)
                    .scaledToFit()
            }
            .buttonStyle(.plain)
        }
    }
}

// struct TodoItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        TodoItemView()
//    }
// }
