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
        HStack(spacing: 0) {
            Button(action: doneAction) {
                Circle()
                    .fill(Color.yellow)
                    .frame(width: 40, height: 40)
                    .overlay(
                        Circle()
                            .stroke(Color.red)
                    )
            }
            .buttonStyle(.plain)
            .padding(.trailing, 8)

            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.system(size: 16, weight: .bold))
                if let desc = item.description, !desc.isEmpty {
                    Text(desc)
                        .font(.system(size: 14, weight: .regular))
                }
            }

            Spacer(minLength: 0)

            Button(action: editAction) {
                Image(systemName: "square.and.pencil")
                    .resizable()
                    .frame(width: 24, height: 24)
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
