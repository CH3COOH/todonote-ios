//
//  CancelEditTodoUseCase.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/09.
//

import Foundation

class CancelEditTodoUseCase: UseCaseProctol {
    private let todoRepository: TodoRepository

    init(
        todoRepository: TodoRepository = TodoRepository()
    ) {
        self.todoRepository = todoRepository
    }

    func execute(_ input: CancelEditTodoUseCaseInput) async -> CancelEditTodoUseCaseResult {
        return await deleteEditingStatusTodo(input: input)
    }

    // 入力された `todoId` の `editing` ステータスの Todo アイテムを削除する
    private func deleteEditingStatusTodo(input: CancelEditTodoUseCaseInput) async -> CancelEditTodoUseCaseResult {
        do {
            try await todoRepository.delete(by: input.todoId, status: .editing)
            return .success
        } catch {
            return .failed(error)
        }
    }
}
