//
//  SyncReadyTodoUseCase.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/09.
//

import Foundation

class SyncReadyTodoUseCase: UseCaseProctol {
    func execute(_ input: SyncReadyTodoUseCaseInput) async -> SyncReadyTodoUseCaseResult {
        return await addTodo(input: input)
    }

    private func addTodo(input _: SyncReadyTodoUseCaseInput) async -> SyncReadyTodoUseCaseResult {
        return .success
    }
}
