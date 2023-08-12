//
//  FetchTodoListUseCase.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/09.
//

import Foundation

class FetchTodoListUseCase: UseCaseProtocol {
    private let todoRepository: TodoRepository

    init(todoRepository: TodoRepository = TodoRepository()) {
        self.todoRepository = todoRepository
    }

    func execute(_ input: FetchTodoListUseCaseInput) async -> FetchTodoListUseCaseResult {
        return await fetchTodoWithSpecifiedId(input: input)
    }

    private func fetchTodoWithSpecifiedId(input: FetchTodoListUseCaseInput) async -> FetchTodoListUseCaseResult {
        do {
            return .success(["aaaa": []])
        } catch {
            return .failed(error)
        }
    }
}
