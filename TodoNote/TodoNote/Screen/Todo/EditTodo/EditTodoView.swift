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
        ScrollView {
            VStack {
                Color.clear.frame(height: 16)

                VStack(alignment: .leading) {
                    R.string.localizable.title.text
                }

                TextField("キャベツを買う", text: $model.todoTitle)

                VStack(alignment: .leading) {
                    R.string.localizable.desc.text
                }

                TextField("スーパーは高いので商店街の八百屋で買うこと", text: $model.todoDescription)

                VStack(alignment: .leading) {
                    R.string.localizable.desc.text
                }

                DatePicker("期限", selection: $model.todoDate)
                    .labelsHidden()

                AccentButton(
                    title: Text(model.buttonTitle),
                    action: {
                        model.onClickAddButton(from: viewController)
                    }
                )
            }
            .padding(.horizontal, 24)
        }
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
