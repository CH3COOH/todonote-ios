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
    private let firestore = Firestore.firestore()

    init(
        firestoreRepository: FirestoreRepository = FirestoreRepository(),
        todoRepository: TodoRepository = TodoRepository()
    ) {
        self.firestoreRepository = firestoreRepository
        self.todoRepository = todoRepository
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

    /// Firestore へデータを同期する
    private func syncItems(input _: SyncReadyTodoUseCaseInput, items: [Todo]) async -> SyncReadyTodoUseCaseResult {
        do {
            for item in items {
                if item.finished {
                    try await firestoreRepository.addOrUpdate(object: item)
                } else {
                    try await firestoreRepository.delete(object: item)
                }
            }

            return await updateLocalData(items: items)
        } catch {
            return .failed(error)
        }
    }

    private func updateLocalData(items _: [Todo]) async -> SyncReadyTodoUseCaseResult {
        // TODO: ローカルのTODOアイテムのステータスを complete に変更する

        // TODO: finished になっていて、サーバー上のアイテムを削除済みの場合は、ローカルデータも併せて削除する

        return .success
    }
}
