//
//  SyncReadyTodoUseCase.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/09.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

/// BL-Z01 データの同期
class SyncReadyTodoUseCase: UseCaseProtocol {
    private let checkNetworkAccessUseCase: CheckNetworkAccessUseCase
    private let firestoreRepository: FirestoreRepository
    private let todoRepository: TodoRepository

    init(
        firestoreRepository: FirestoreRepository = FirestoreRepository(),
        todoRepository: TodoRepository = TodoRepository(),
        checkNetworkAccessUseCase: CheckNetworkAccessUseCase = CheckNetworkAccessUseCase()
    ) {
        self.firestoreRepository = firestoreRepository
        self.todoRepository = todoRepository
        self.checkNetworkAccessUseCase = checkNetworkAccessUseCase
    }

    func execute(_ input: SyncReadyTodoUseCaseInput) async -> SyncReadyTodoUseCaseResult {
        return await fetchReadyItems(input: input)
    }

    private func fetchReadyItems(input: SyncReadyTodoUseCaseInput) async -> SyncReadyTodoUseCaseResult {
        do {
            let results = try await todoRepository.fetch(with: [.ready])
            if results.isEmpty {
                return .success
            }

            return await availableNetworkAccess(input: input, items: results)
        } catch {
            return .failed(error)
        }
    }

    /// ネットワーク接続が可能か調べる
    private func availableNetworkAccess(input: SyncReadyTodoUseCaseInput, items: [Todo]) async -> SyncReadyTodoUseCaseResult {
        let result = await checkNetworkAccessUseCase.execute(.init())
        switch result {
        case .connected:
            return await syncItems(input: input, items: items)
        case .unavailable:
            // ネットワークに接続されていない場合、ここで処理を終える
            return .success
        }
    }

    /// Firestore へデータを同期する
    private func syncItems(input: SyncReadyTodoUseCaseInput, items: [Todo]) async -> SyncReadyTodoUseCaseResult {
        do {
            for item in items {
                if item.finished {
                    try await firestoreRepository.delete(object: item)
                } else {
                    try await firestoreRepository.addOrUpdate(object: item)
                }
            }

            let newItems = items.map { todo in
                todo.copy(
                    status: .complete,
                    updatedAt: Date()
                )
            }
            return await updateLocalData(input: input, items: newItems)
        } catch {
            return .failed(error)
        }
    }

    private func updateLocalData(input _: SyncReadyTodoUseCaseInput, items: [Todo]) async -> SyncReadyTodoUseCaseResult {
        do {
            for item in items {
                if item.finished {
                    try await todoRepository.delete(by: item.todoId)
                } else {
                    try await todoRepository.updateTodoStatus(
                        for: item,
                        with: RegistrationStatus.all
                    )
                }
            }
            return .success
        } catch {
            return .failed(error)
        }
    }
}
