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

    @ObservedObject var model: EditTodoViewModel

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
                    VStack(spacing: 16) {
                        SectionItem(
                            title: R.string.localizable.title()
                        )
                        .font(.headline)

                        TextField("キャベツを買う", text: $model.todoTitle)
                            .padding()
                            .background(Color(uiColor: UIColor.systemBackground))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(
                                        model.errorTitle.isEmpty ? Color.gray.opacity(0.5) : Color.red,
                                        lineWidth: 1
                                    )
                            )

                        if !model.errorTitle.isEmpty {
                            HStack {
                                Text(model.errorTitle)
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundColor(Color.red)

                                Spacer(minLength: 0)
                            }
                        }

                        DatePicker(
                            R.string.localizable.deadline(),
                            selection: $model.todoDate,
                            displayedComponents: [.date, .hourAndMinute]
                        )
                        .datePickerStyle(DefaultDatePickerStyle())

                        SectionItem(
                            title: R.string.localizable.desc()
                        )
                        .font(.headline)

                        ZStack {
                            TextEditor(text: $model.todoDescription)
                                .frame(minHeight: 40)
                                .padding()
                                .background(Color(uiColor: UIColor.systemBackground))
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
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
                    .padding(16)
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
