//
//  DoneTodoUseCase.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/09.
//

import Foundation

/// BL-B02 TODOアイテムの削除
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
        return await markTodoAsDone(input: input)
    }

    private func markTodoAsDone(input: DoneTodoUseCaseInput) async -> DoneTodoUseCaseResult {
        do {
            let newTodo = input.todo.copy(
                status: .ready,
                finished: true
            )
            try await todoRepository.updateTodoStatus(
                for: newTodo,
                with: RegistrationStatus.all
            )
            return await availableNetworkAccess(todo: newTodo)
        } catch {
            return .failed(error)
        }
    }

    private func availableNetworkAccess(todo: Todo) async -> DoneTodoUseCaseResult {
        let result = await checkNetworkAccessUseCase.execute(.init())
        switch result {
        case .connected:
            return await syncTodoWithServer(todo: todo)
        case .unavailable:
            // ネットワークに接続されていない場合、ここで処理を終える
            return .success
        }
    }

    private func syncTodoWithServer(todo: Todo) async -> DoneTodoUseCaseResult {
        do {
            try await firestoreRepository.delete(object: todo)

            return await finalizeTodoSync(todo: todo)
        } catch {
            // サーバーへの書き込みに失敗しても失敗とはみなさない
            print(error.localizedDescription)
            return .success
        }
    }

    private func finalizeTodoSync(todo: Todo) async -> DoneTodoUseCaseResult {
        do {
            try await todoRepository.delete(by: todo.id)
            return .success
        } catch {
            print(error.localizedDescription)
            return .success
        }
    }
}
