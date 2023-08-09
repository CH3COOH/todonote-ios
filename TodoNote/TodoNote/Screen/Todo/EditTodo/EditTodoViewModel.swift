//
//  EditTodoViewModel.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/07.
//

import SwiftUI
import ULID

class EditTodoViewModel: ObservableObject {
    @Published var title = ""

    @Published var todoTitle = ""

    @Published var todoDescription = ""

    @Published var todoDate = Date()

    @Published var alertItem: AlertItem?

    private let todoId: TodoId

    private let updateTodoUseCase = UpdateTodoUseCase()

    init(todoId: TodoId?) {
        if let todoId = todoId {
            self.todoId = todoId
            title = "編集"
        } else {
            let id = ULID().ulidString
            self.todoId = TodoId(rawValue: id)
            title = "登録"
        }
    }

    func onAppear() {}

    func onClickAddButton(from viewController: UIViewController?) {
        Task {
            let input = UpdateTodoUseCaseInput(
                todoId: todoId,
                title: todoTitle,
                description: todoDescription,
                datetime: todoDate
            )
            let result = await updateTodoUseCase.execute(input)
            switch result {
            case .success:
                await viewController?.dismiss(animated: true)
            case let .failed(error):
                alertItem = AlertItem(
                    alert: Alert(
                        title: R.string.localizable.error.text,
                        message: Text(error.localizedDescription)
                    )
                )
            }
        }
    }
}
