//
//  UpdateTodoUseCase.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/09.
//

import Foundation
import UserNotifications

class UpdateTodoUseCase: UseCaseProtocol {
    private let firestoreRepository: FirestoreRepository
    private let todoRepository: TodoRepository
    private let checkNetworkAccessUseCase: CheckNetworkAccessUseCase

    init(
        firestoreRepository: FirestoreRepository = FirestoreRepository(),
        todoRepository: TodoRepository = TodoRepository(),
        checkNetworkAccessUseCase: CheckNetworkAccessUseCase = CheckNetworkAccessUseCase()
    ) {
        self.firestoreRepository = firestoreRepository
        self.todoRepository = todoRepository
        self.checkNetworkAccessUseCase = checkNetworkAccessUseCase
    }

    func execute(_ input: UpdateTodoUseCaseInput) async -> UpdateTodoUseCaseResult {
        return await saveTodoLocally(input: input)
    }

    /// ローカルでTodoを保存する
    private func saveTodoLocally(input: UpdateTodoUseCaseInput) async -> UpdateTodoUseCaseResult {
        do {
            let newTodo = input.todo.copy(
                status: .ready,
                updatedAt: Date()
            )
            try await todoRepository.updateTodoStatus(
                for: newTodo,
                with: RegistrationStatus.all
            )
            return await reScheduleNotification(todo: newTodo)
        } catch {
            return .failed(error)
        }
    }

    private func reScheduleNotification(todo: Todo) async -> UpdateTodoUseCaseResult {
        do {
            let center = UNUserNotificationCenter.current()

            // 既存の通知リクエストを削除する
            center.removePendingNotificationRequests(
                withIdentifiers: [
                    todo.todoId.rawValue,
                ]
            )

            // 新規に通知リクエストを登録しなおす
            let content = UNMutableNotificationContent()
            content.title = todo.title
            content.body = todo.description ?? ""
            content.sound = UNNotificationSound.default
            content.userInfo = ["todoID": todo.todoId.rawValue]

            let components = Calendar.current.dateComponents(
                [.year, .month, .day, .hour, .minute],
                from: todo.datetime
            )
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)

            let request = UNNotificationRequest(
                identifier: todo.todoId.rawValue,
                content: content,
                trigger: trigger
            )

            try await center.add(request)

            return await availableNetworkAccess(todo: todo)
        } catch {
            return .failed(error)
        }
    }

    /// ネットワーク接続が可能か調べる
    private func availableNetworkAccess(todo: Todo) async -> UpdateTodoUseCaseResult {
        let result = await checkNetworkAccessUseCase.execute(.init())
        switch result {
        case .connected:
            return await syncTodoWithServer(todo: todo)
        case .unavailable:
            // ネットワークに接続されていない場合、ここで処理を終える
            return .success
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

    /// サーバー同期が成功すると、ステータスを complete に変更する
    private func markSyncComplete(todo: Todo) async -> UpdateTodoUseCaseResult {
        do {
            let updatedTodo = todo.copy(
                status: .complete,
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
