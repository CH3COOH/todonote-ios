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
        var array: [TodoSection] = []
        switch input.sortType {
        case .standard:
            // 今日と期限切れのセクション
            let todaysAndOverdueTasks = items.filter {
                let calendar = Calendar.current
                return calendar.isDateInToday($0.datetime) || $0.datetime < Date()
            }
            if !todaysAndOverdueTasks.isEmpty {
                array.append(
                    TodoSection(
                        title: R.string.localizable.home_today_and_overdue(),
                        todos: todaysAndOverdueTasks
                    )
                )
            }

            // 日別ごとのセクション
            let groupedItems = Dictionary(grouping: items) { (todo: Todo) -> Date in
                let calendar = Calendar.current
                return calendar.startOfDay(for: todo.datetime)
            }
            .sorted { $0.key < $1.key }

            for (date, todos) in groupedItems {
                if Calendar.current.isDateInToday(date) || todos.first!.datetime < Date() {
                    continue
                }
                let title = DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .none)
                array.append(TodoSection(title: title, todos: todos))
            }

        case let .createdAt(isAscending):
            let sortedTasks = items.sorted(by: {
                isAscending ? $0.createdAt < $1.createdAt : $0.createdAt > $1.createdAt
            })
            let title = R.string.localizable.create_date()
            array.append(
                TodoSection(title: title, todos: sortedTasks)
            )

        case let .updatedAt(isAscending):
            let sortedTasks = items.sorted(by: {
                isAscending ? $0.updatedAt < $1.updatedAt : $0.updatedAt > $1.updatedAt
            })
            let title = R.string.localizable.modified_date()
            array.append(
                TodoSection(title: title, todos: sortedTasks)
            )
        }

        return .success(array)
    }
}
