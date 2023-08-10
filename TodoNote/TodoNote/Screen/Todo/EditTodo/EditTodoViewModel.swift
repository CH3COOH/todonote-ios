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

    @Published var originalTodo: Todo?

    @Published var todoTitle = ""

    @Published var todoDescription = ""

    @Published var todoDate = Date()

    @Published var alertItem: AlertItem?

    @Published var isLoaded = false

    @Published var isEnabled = false

    private let todoId: TodoId

    private let fetchTodoUseCase = FetchTodoUseCase()

    private let cancelEditTodoUseCase = CancelEditTodoUseCase()

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

    func onAppear(from viewController: UIViewController?) {
        Task {
            let result = await fetchTodoUseCase.execute(.init(todoId: todoId))
            switch result {
            case let .success(todo):
                await set(todo: todo)
            case let .failed(error):
                alertItem = AlertItem(
                    alert: Alert(
                        title: R.string.localizable.error.text,
                        message: Text(error.localizedDescription),
                        dismissButton: .default(R.string.localizable.ok.text) {
                            Task { @MainActor in
                                viewController?.dismiss(animated: true)
                            }
                        }
                    )
                )
            }
        }
    }

    func onClickCloseButton(from viewController: UIViewController?) {
        Task {
            let result = await cancelEditTodoUseCase.execute(.init(todoId: todoId))
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

    func onClickAddButton(from viewController: UIViewController?) {
        guard let todo = originalTodo else {
            return
        }

        let newTodo = todo.copy(
            title: todoTitle,
            description: todoDescription,
            datetime: todoDate
        )

        Task {
            let input = UpdateTodoUseCaseInput(
                todo: newTodo
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

    @MainActor
    func set(todo: Todo) {
        isLoaded = true
        originalTodo = todo
        todoTitle = todo.title
        todoDescription = todo.description ?? ""
        todoDate = todo.datetime
    }
}
