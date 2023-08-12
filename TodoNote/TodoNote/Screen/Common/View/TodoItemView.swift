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
                    .fill(computeFillColor())
                    .frame(width: 32, height: 32)
                    .overlay(
                        Circle()
                            .stroke(computeStrokeColor())
                    )
            }
            .buttonStyle(.plain)
            .padding(.trailing, 12)
            .padding(.vertical, 4)

            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Color.black)
                if let desc = item.description, !desc.isEmpty {
                    Text(desc)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(R.color.grey700.color)
                }
            }

            Spacer(minLength: 0)

            Button(action: editAction) {
                Image(systemName: "pencil")
                    .resizable()
                    .frame(width: 16, height: 16)
                    .scaledToFit()
                    .foregroundColor(R.color.accentColor.color)
            }
            .buttonStyle(.plain)
        }
    }

    private func computeFillColor() -> Color {
        let today = Calendar.current.startOfDay(for: Date())
        let todoDate = Calendar.current.startOfDay(for: item.datetime)

        if todoDate < today {
            return R.color.red50.color
        } else if todoDate == today {
            return R.color.amber50.color
        } else {
            return R.color.lightGreen50.color
        }
    }

    private func computeStrokeColor() -> Color {
        let today = Calendar.current.startOfDay(for: Date())
        let todoDate = Calendar.current.startOfDay(for: item.datetime)

        if todoDate < today {
            return R.color.red700.color
        } else if todoDate == today {
            return R.color.amber700.color
        } else {
            return R.color.lightGreen700.color
        }
    }
}

// struct TodoItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        TodoItemView()
//    }
// }
