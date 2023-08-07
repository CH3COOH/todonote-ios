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

    var body: some View {
        VStack {
            Text("Hello, World!")

            Button(action: onClickAddButton) {
                Text("追加する")
            }
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
                Text("編集")
            }
        }
    }

    private func onClickCloseButton() {
        viewController?.dismiss(animated: true)
    }

    private func onClickAddButton() {
        // TODO:
    }
}

struct EditTodoView_Previews: PreviewProvider {
    static var previews: some View {
        EditTodoView()
    }
}
