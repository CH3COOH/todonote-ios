//
//  FetchTodoUseCase.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/09.
//

import Foundation

class FetchTodoUseCase: UseCaseProctol {
    private let todoRepository: TodoRepository

    init(
        todoRepository: TodoRepository = TodoRepository()
    ) {
        self.todoRepository = todoRepository
    }

    func execute(_ input: FetchTodoUseCaseInput) async -> FetchTodoUseCaseResult {
        return await step1(input: input)
    }

    /// 指定したTodoIdの ステータス が ready か complete のレコードをCore Dataから取得する
    private func step1(input: FetchTodoUseCaseInput) async -> FetchTodoUseCaseResult {
        do {
            let todo = try await todoRepository.fetch(by: input.todoId, statuses: [.ready, .complete])
            return await step2(input: input, todo: todo)
        } catch {
            return .failed(error)
        }
    }

    private func step2(input: FetchTodoUseCaseInput, todo: Todo?) async -> FetchTodoUseCaseResult {
        do {
            let editingTodo: Todo
            if let todo = todo {
                // 既存のレコードをコピーして、ステータスを editing に変更する
                editingTodo = todo.copy(
                    status: .editing
                )
            } else {
                // 新規にステータスが editing のレコードを作成する
                editingTodo = Todo(
                    todoId: input.todoId,
                    status: .editing,
                    title: "",
                    description: nil,
                    datetime: Date(),
                    createdAt: Date(),
                    updatedAt: Date(),
                    finished: false
                )
            }
            try await todoRepository.insert(object: editingTodo)
            return .success(editingTodo)
        } catch {
            return .failed(error)
        }
    }
}
