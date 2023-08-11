//
//  DoneTodoUseCase.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/09.
//

import Foundation

class DoneTodoUseCase: UseCaseProtocol {
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

    func execute(_ input: DoneTodoUseCaseInput) async -> DoneTodoUseCaseResult {
        return await execuhogheogheote(input: input)
    }

    /// finished フラグを true にする
    func execuhogheogheote(input: DoneTodoUseCaseInput) async -> DoneTodoUseCaseResult {
        do {
            let newTodo = input.todo.copy(
                status: .ready,
                finished: true
            )
            try await todoRepository.updateTodoStatus(
                for: newTodo,
                with: RegistrationStatus.all
            )
            return await availableNetworkAccess(input: input, todo: newTodo)
        } catch {
            return .failed(error)
        }
    }

    /// ネットワーク接続が可能か調べる
    private func availableNetworkAccess(input: DoneTodoUseCaseInput, todo: Todo) async -> DoneTodoUseCaseResult {
        let result = await checkNetworkAccessUseCase.execute(.init())
        switch result {
        case .connected:
            return await syncTodoWithServer(input: input, todo: todo)
        case .unavailable:
            // ネットワークに接続されていない場合、ここで処理を終える
            return .success
        }
    }

    /// Todoアイテムをリモートサーバーと同期する
    private func syncTodoWithServer(input _: DoneTodoUseCaseInput, todo: Todo) async -> DoneTodoUseCaseResult {
        do {
            try await firestoreRepository.delete(object: todo)

            return await markSyncComplete(todo: todo)
        } catch {
            // サーバーへの書き込みに失敗しても、ユースケースの失敗とはみなさない
            return .success
        }
    }

    /// サーバー同期が成功すると、ステータスを complete に変更する
    private func markSyncComplete(todo: Todo) async -> DoneTodoUseCaseResult {
        do {
            try await todoRepository.delete(by: todo.id)
            return .success
        } catch {
            return .success
        }
    }
}
