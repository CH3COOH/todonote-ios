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

    private func fetchTodoWithSpecifiedId(input _: FetchTodoListUseCaseInput) async -> FetchTodoListUseCaseResult {
        do {
            let resitory = TodoRepository()
            let items = try await resitory.fetch(with: [.ready, .complete])

            let array = [
                TodoSection(title: "あああああ", todos: items),
                TodoSection(title: "いいいい", todos: items),
            ]

            return .success(array)
        } catch {
            return .failed(error)
        }
    }

    // TODO: ready と complete のレコードだけをピックアップする

    // TODO: finished のチェックがついたのはリストに含めない
}
