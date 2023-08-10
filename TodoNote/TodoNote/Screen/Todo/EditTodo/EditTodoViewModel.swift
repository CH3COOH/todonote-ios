//
//  EditTodoViewModel.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/07.
//

import SwiftUI
import ULID

class EditTodoViewModel: ObservableObject {
    @Published var screenTitle = "Edit Todo"

    @Published var buttonTitle = "Add"

    @Published var todoTitle = ""

    @Published var todoDescription = ""

    @Published var todoDate = Date()

    @Published var alertItem: AlertItem?

    private let todoId: TodoId

    private let updateTodoUseCase = UpdateTodoUseCase()

    init(todoId: TodoId?) {
        if let todoId = todoId {
            self.todoId = todoId
            screenTitle = R.string.localizable.edit_todo_title_edit()
            buttonTitle = R.string.localizable.edit_todo_button_update()
        } else {
            let id = ULID().ulidString
            self.todoId = TodoId(rawValue: id)
            screenTitle = R.string.localizable.edit_todo_title_create()
            buttonTitle = R.string.localizable.edit_todo_button_create()
        }
    }

    func onAppear() {
        todoTitle = todoId.rawValue
        todoDescription = todoId.rawValue
    }

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
