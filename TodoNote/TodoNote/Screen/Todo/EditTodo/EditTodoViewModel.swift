//
//  EditTodoViewModel.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/07.
//

import KRProgressHUD
import SwiftUI
import ULID

class EditTodoViewModel: BaseViewModel {
    @Published var screenTitle = "Edit Todo"

    @Published var buttonTitle = "Add"

    @Published var originalTodo: Todo?

    @Published var todoTitle = ""

    @Published var todoDescription = ""

    @Published var todoDate = Date()

    @Published var isLoaded = false

    @Published var errorTitle = ""

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
                await show(error: error) {
                    Task { @MainActor in
                        viewController?.dismiss(animated: true)
                    }
                }
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
                await show(error: error)
            }
        }
    }

    func onClickAddButton(from viewController: UIViewController?) {
        guard let todo = originalTodo else {
            return
        }

        let trimmedTitle = todoTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedTitle.isEmpty {
            errorTitle = "タイトルは入力必須項目です"
            return
        } else {
            errorTitle = ""
        }
        let trimmedDescription = todoDescription.trimmingCharacters(in: .whitespacesAndNewlines)

        let newTodo = todo.copy(
            title: trimmedTitle,
            description: trimmedDescription,
            datetime: todoDate,
            updatedAt: Date()
        )

        KRProgressHUD.show()
        Task {
            let input = UpdateTodoUseCaseInput(
                todo: newTodo
            )
            let result = await updateTodoUseCase.execute(input)
            KRProgressHUD.dismiss()
            switch result {
            case .success:
                await viewController?.dismiss(animated: true)
            case let .failed(error):
                await show(error: error)
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

    private func isValidInput() -> Bool {
        let trimmedTitle = todoTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        let isTitleEmpty = trimmedTitle.isEmpty
        let isFutureDate = todoDate > Date()

        print("\(isTitleEmpty)")
        print("\(isFutureDate)")

        return !isTitleEmpty && isFutureDate
    }
}
