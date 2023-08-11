//
//  FetchTodoUseCase.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/09.
//

import Foundation

class FetchTodoUseCase: UseCaseProctol {
    private let todoRepository: TodoRepository

    init(todoRepository: TodoRepository = TodoRepository()) {
        self.todoRepository = todoRepository
    }

    func execute(_ input: FetchTodoUseCaseInput) async -> FetchTodoUseCaseResult {
        return await fetchTodoWithSpecifiedId(input: input)
    }

    /// 特定のステータス (`ready` または `complete`) を持つ ToDo を Core Data から取得する
    private func fetchTodoWithSpecifiedId(input: FetchTodoUseCaseInput) async -> FetchTodoUseCaseResult {
        do {
            let todo = try await todoRepository.fetch(
                by: input.todoId,
                with: [.ready, .complete]
            )
            return await prepareEditingTodo(input: input, todo: todo)
        } catch {
            return .failed(error)
        }
    }

    /// 編集用のTodoを準備する。既存のTodoのステータスを更新するか、新しいTodoを作成する
    private func prepareEditingTodo(input: FetchTodoUseCaseInput, todo: Todo?) async -> FetchTodoUseCaseResult {
        do {
            let editingTodo: Todo
            if let todo = todo {
                editingTodo = todo.copy(status: .editing)
            } else {
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
