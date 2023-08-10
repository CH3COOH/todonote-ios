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
            ScrollView {
                VStack(spacing: 0) {
                    Color.clear.frame(height: 24)

                    SectionItem(
                        title: R.string.localizable.title()
                    )
                    .padding(.bottom, 8)

                    TextField("キャベツを買う", text: $model.todoTitle)
                        .padding(.bottom, 32)

                    DatePicker(
                        R.string.localizable.deadline(),
                        selection: $model.todoDate
                    )
                    .padding(.bottom, 32)

                    SectionItem(
                        title: R.string.localizable.desc()
                    )
                    .padding(.bottom, 8)

                    ZStack {
                        TextEditor(text: $model.todoDescription)
                            .padding(.bottom, 32)

                        if model.todoDescription.isEmpty {
                            R.string.localizable.edit_todo_hint_desc.text
                                .foregroundColor(Color.gray)
                        }
                    }
                }
                .padding(.horizontal, 24)
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
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: onClickCloseButton) {
                    Label(
                        R.string.localizable.close(),
                        systemImage: "xmark"
                    )
                }
            }
            ToolbarItem(placement: .principal) {
                Text(model.screenTitle)
            }
        }
        .onAppear {
            model.onAppear()
        }
    }

    private func onClickCloseButton() {
        viewController?.dismiss(animated: true)
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
