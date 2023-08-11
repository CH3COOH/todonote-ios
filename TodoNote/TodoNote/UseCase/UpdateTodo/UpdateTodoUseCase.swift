//
//  UpdateTodoUseCase.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/09.
//

import Foundation

class UpdateTodoUseCase: UseCaseProtocol {
    private let resitory: TodoRepository

    init(resitory: TodoRepository = TodoRepository()) {
        self.resitory = resitory
    }

    func execute(_ input: UpdateTodoUseCaseInput) async -> UpdateTodoUseCaseResult {
        return await addTodo(input: input)
    }

    private func addTodo(input: UpdateTodoUseCaseInput) async -> UpdateTodoUseCaseResult {
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
            try await resitory.addOrUpdate(object: todo1)

            return .success
        } catch {
            return .failed(error)
        }
    }
}
