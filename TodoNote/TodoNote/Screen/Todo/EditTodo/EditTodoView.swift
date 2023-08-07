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

    @StateObject var model = EditTodoViewModel()

    var body: some View {
        ScrollView {
            VStack {
                Text("タイトル")

                TextField("キャベツを買う", text: $model.title)

                Text("詳細")

                TextField("スーパーは高いので商店街の八百屋で買うこと", text: $model.body)

                DatePicker("明日", selection: $model.date)

                Button(action: onClickAddButton) {
                    HStack {
                        Text("保存する")
                            .foregroundColor(Color.white)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(R.color.accentColor.color)
                    )
                }
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
