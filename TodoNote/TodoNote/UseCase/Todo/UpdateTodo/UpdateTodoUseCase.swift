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
        return await addTodoToLocal(input: input)
    }

    private func addTodoToLocal(input: UpdateTodoUseCaseInput) async -> UpdateTodoUseCaseResult {
        do {
            let todo1 = Todo(
                todoId: input.todoId,
                status: RegistrationStatus.ready,
                title: input.title,
                description: input.description,
                datetime: input.datetime,
                createdAt: Date(),
                updatedAt: Date(),
                finished: false
            )
            try await todoRepository.addOrUpdate(object: todo1)

            return await addTodoToRemote(input: input, item: todo1)
        } catch {
            return .failed(error)
        }
    }

    private func addTodoToRemote(input _: UpdateTodoUseCaseInput, item: Todo) async -> UpdateTodoUseCaseResult {
        do {
            try await firestoreRepository.addOrUpdate(object: item)

            return .success
        } catch {
            // サーバーへの書き込み失敗は、UseCase の失敗とはみなさない
            return .success
        }
    }

    /// サーバーへの同期が完了したので、status を complete に更新する
    private func updateStatus(input _: UpdateTodoUseCaseInput, item: Todo) async -> UpdateTodoUseCaseResult {
        do {
            let newItem = item.copy(
                status: RegistrationStatus.complete,
                updatedAt: Date()
            )
            try await todoRepository.addOrUpdate(object: newItem)

            return .success
        } catch {
            return .success
        }
    }
}
