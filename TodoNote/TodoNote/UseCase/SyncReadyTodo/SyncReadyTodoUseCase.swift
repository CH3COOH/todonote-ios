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

    func execute(_ input: SyncReadyTodoUseCaseInput) async -> SyncReadyTodoUseCaseResult {
        return await fetchReadyItems(input: input)
    }

    private func fetchReadyItems(input: SyncReadyTodoUseCaseInput) async -> SyncReadyTodoUseCaseResult {
        do {
            let results = try await todoRepository.fetch(with: [.ready])
            if results.isEmpty {
                return .success
            }

            return await syncItems(input: input, items: results)
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
                    try await firestoreRepository.addOrUpdate(object: item)
                } else {
                    try await firestoreRepository.delete(object: item)
                }
            }

            return await updateLocalData(input: input, items: items)
        } catch {
            return .failed(error)
        }
    }

    private func updateLocalData(input _: SyncReadyTodoUseCaseInput, items _: [Todo]) async -> SyncReadyTodoUseCaseResult {
        // TODO: ローカルのTODOアイテムのステータスを complete に変更する

        // TODO: finished になっていて、サーバー上のアイテムを削除済みの場合は、ローカルデータも併せて削除する

        return .success
    }
}
