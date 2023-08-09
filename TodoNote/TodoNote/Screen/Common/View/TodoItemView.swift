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
                Image(systemName: "square")
                    .resizable()
                    .frame(width: 44, height: 44)
                    .scaledToFit()
            }
            .buttonStyle(.plain)

            VStack(alignment: .leading) {
                Text(item.title)
                if let desc = item.description, !desc.isEmpty {
                    Text(desc)
                }
            }

            Spacer(minLength: 0)

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
