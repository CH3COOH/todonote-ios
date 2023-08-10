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

    /// ローカルでTodoを保存し、リモートサーバーとの同期を試みる
    private func saveTodoLocally(input: UpdateTodoUseCaseInput) async -> UpdateTodoUseCaseResult {
        do {
            let newTodo = Todo(
                todoId: input.todoId,
                status: RegistrationStatus.ready,
                title: input.title,
                description: input.description,
                datetime: input.datetime,
                createdAt: Date(),
                updatedAt: Date(),
                finished: false
            )
            try await todoRepository.addOrUpdate(object: newTodo)

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
            try await todoRepository.addOrUpdate(object: updatedTodo)

            return .success
        } catch {
            // Even if marking as complete fails, it's still a successful sync.
            return .success
        }
    }
}
