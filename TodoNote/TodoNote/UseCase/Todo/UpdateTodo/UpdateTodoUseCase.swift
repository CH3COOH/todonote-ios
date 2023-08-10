//
//  UpdateTodoUseCase.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/09.
//

import Foundation

class UpdateTodoUseCase: UseCaseProctol {
    private let firestoreRepository: FirestoreRepository
    private let todoRepository: TodoRepository

    init(
        firestoreRepository: FirestoreRepository = FirestoreRepository(),
        todoRepository: TodoRepository = TodoRepository()
    ) {
        self.firestoreRepository = firestoreRepository
        self.todoRepository = todoRepository
    }

    func execute(_ input: UpdateTodoUseCaseInput) async -> UpdateTodoUseCaseResult {
        return await saveTodoLocally(input: input)
    }

    /// ローカルでTodoを保存する
    private func saveTodoLocally(input: UpdateTodoUseCaseInput) async -> UpdateTodoUseCaseResult {
        do {
            let newTodo = input.todo.copy(
                status: RegistrationStatus.ready,
                updatedAt: Date()
            )
            try await todoRepository.updateTodoStatus(
                for: newTodo,
                with: RegistrationStatus.all
            )
            return await syncTodoWithServer(todo: newTodo)
        } catch {
            return .failed(error)
        }
    }

    /// Todoアイテムをリモートサーバーと同期する
    private func syncTodoWithServer(todo: Todo) async -> UpdateTodoUseCaseResult {
        do {
            try await firestoreRepository.addOrUpdate(object: todo)

            return await markSyncComplete(todo: todo)
        } catch {
            // サーバーへの書き込みに失敗しても、ユースケースの失敗とはみなさない
            return .success
        }
    }

    /// サーバー同期が成功すると、同期ステータスを完了としてマークする
    private func markSyncComplete(todo: Todo) async -> UpdateTodoUseCaseResult {
        do {
            let updatedTodo = todo.copy(
                status: RegistrationStatus.complete,
                updatedAt: Date()
            )
            try await todoRepository.updateTodoStatus(
                for: updatedTodo,
                with: RegistrationStatus.all
            )
            return .success
        } catch {
            return .success
        }
    }
}
