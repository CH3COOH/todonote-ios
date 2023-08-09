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
class SyncReadyTodoUseCase: UseCaseProctol {
    private let todoRepository: TodoRepository
    private let firestore = Firestore.firestore()

    init(todoRepository: TodoRepository = TodoRepository()) {
        self.todoRepository = todoRepository
    }

    func execute(_ input: SyncReadyTodoUseCaseInput) async -> SyncReadyTodoUseCaseResult {
        return await fetchReadyItems(input: input)
    }

    private func fetchReadyItems(input: SyncReadyTodoUseCaseInput) async -> SyncReadyTodoUseCaseResult {
        do {
            let results = try await todoRepository.fetch(status: RegistrationStatus.ready)
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
            guard let userId = Auth.auth().currentUser?.uid else {
                fatalError("UserId が取得できない")
            }

            let collectionRef = firestore.collection("version/1/users/\(userId)/items")
            for item in items {
                let documentRef = collectionRef.document(item.todoId.rawValue)
                if item.finished {
                    try await documentRef.delete()
                } else {
                    try await documentRef.setData(
                        [
                            "title": item.title,
                            "desc": item.description ?? "",
                            "datetime": item.datetime,
                            "create_at": item.createdAt,
                            "update_at": item.updatedAt,
                        ]
                    )
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
