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
            let resitory = TodoRepository()
            let items = try await resitory.fetch(with: [.ready, .complete])

            return await grouping(input: input, items: items.filter { !$0.finished })
        } catch {
            return .failed(error)
        }
    }

    private func grouping(input: FetchTodoListUseCaseInput, items: [Todo]) async -> FetchTodoListUseCaseResult {
        var array: [TodoSection]
        switch input.sortType {
        case .hogehoge:
            array = [
                TodoSection(title: "あああああ", todos: items),
                TodoSection(title: "いいいい", todos: items),
            ]
        case let .createAt(isAscending):
            let hoge = items.sorted { rhs, lhs in
                if isAscending {
                    return rhs.createdAt < rhs.createdAt
                } else {
                    return rhs.createdAt > rhs.createdAt
                }
            }
            array = [
                TodoSection(
                    title: "",
                    todos: hoge
                )
            ]
        }

        return .success(array)
    }
}
