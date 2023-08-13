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
        Button(action: editAction) {
            HStack(spacing: 0) {
                Button(action: doneAction) {
                    ZStack {
                        Circle()
                            .fill(computeFillColor())
                            .overlay(
                                Circle()
                                    .stroke(computeStrokeColor())
                            )
                        Image(systemName: "checkmark")
                            .resizable()
                            .frame(width: 12, height: 12)
                            .scaledToFit()
                            .foregroundColor(Color.white)
                            .opacity(0.4)
                    }
                    .frame(width: 32, height: 32)
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
            }
        }
    }

    private func computeFillColor() -> Color {
        let today = Calendar.current.startOfDay(for: Date())
        let todoDate = Calendar.current.startOfDay(for: item.datetime)

        if todoDate < today {
            return R.color.red300.color
        } else if todoDate == today {
            return R.color.amber300.color
        } else {
            return R.color.lightGreen300.color
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
