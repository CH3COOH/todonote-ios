//
//  EditTodoView.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/07.
//

import SwiftUI

struct EditTodoView: View {
    @Environment(\.viewController) private var viewControllerHolder: ViewControllerHolder
    private var viewController: UIViewController? {
        viewControllerHolder.value
    }

    @StateObject var model: EditTodoViewModel

    var body: some View {
        VStack(spacing: 0) {
            if !model.isLoaded {
                ActivityIndicatorView(
                    style: .medium,
                    color: R.color.accentColor()!
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    VStack(spacing: 16) { // スペーシングを調整
                        SectionItem(
                            title: R.string.localizable.title()
                        )
                        .font(.headline) // セクションのタイトルのフォントを調整

                        TextField("キャベツを買う", text: $model.todoTitle)
                            .padding()
                            .background(Color(uiColor: UIColor.systemBackground)) // 背景色を追加
                            .cornerRadius(8) // 角を丸くする
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 1) // 枠線を追加
                            )

                        DatePicker(
                            R.string.localizable.deadline(),
                            selection: $model.todoDate,
                            displayedComponents: .date
                        )
                        .datePickerStyle(CompactDatePickerStyle()) // スタイルを変更

                        SectionItem(
                            title: R.string.localizable.desc()
                        )
                        .font(.headline) // セクションのタイトルのフォントを調整

                        ZStack {
                            TextEditor(text: $model.todoDescription)
                                .frame(minHeight: 40)
                                .padding()
                                .background(Color(uiColor: UIColor.systemBackground)) // 背景色を追加
                                .cornerRadius(8) // 角を丸くする
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray.opacity(0.5), lineWidth: 1) // 枠線を追加
                                )

                            if model.todoDescription.isEmpty {
                                HStack {
                                    R.string.localizable.edit_todo_hint_desc.text
                                        .foregroundColor(Color.gray)
                                        .allowsHitTesting(false)
                                        .padding(.leading, 20)

                                    Spacer(minLength: 0)
                                }
                                .frame(maxWidth: .infinity)
                            }
                        }
                    }
                    .padding(16) // ScrollViewのパディングを調整
                }
            }

            VStack(spacing: 0) {
                Rectangle()
                    .fill(Color(uiColor: UIColor.separator))
                    .frame(maxWidth: .infinity)
                    .frame(height: 1)

                AccentButton(
                    title: Text(model.buttonTitle),
                    action: {
                        model.onClickAddButton(from: viewController)
                    }
                )
                .padding(.horizontal, 24)
                .padding(.vertical, 8)
            }
            .background(Color.white)
        }
        .background(Color(uiColor: UIColor.systemGroupedBackground))
        .navigationTitle(Text(model.screenTitle))
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: onClickCloseButton) {
                    R.string.localizable.close.text
                }
            }
//            ToolbarItem(placement: .principal) {
//                Text(model.screenTitle)
//            }
        }
        .onAppear {
            model.onAppear(from: viewController)
        }
    }

    private func onClickCloseButton() {
        model.onClickCloseButton(from: viewController)
    }
}

struct EditTodoView_Previews: PreviewProvider {
    static var model = EditTodoViewModel(
        todoId: nil
    )

    static var previews: some View {
        NavigationView {
            EditTodoView(model: model)
        }
    }
}
