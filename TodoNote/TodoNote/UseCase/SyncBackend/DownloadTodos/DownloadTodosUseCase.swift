//
//  DownloadTodosUseCase.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/09.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

/// BL-Z02 TODOアイテムのダウンロード
class DownloadTodosUseCase: UseCaseProtocol {
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

    func execute(_ input: DownloadTodosUseCaseInput) async -> DownloadTodosUseCaseResult {
        return await availableNetworkAccess(input: input)
    }

    /// ネットワーク接続が可能か調べる
    private func availableNetworkAccess(input: DownloadTodosUseCaseInput) async -> DownloadTodosUseCaseResult {
        let result = await checkNetworkAccessUseCase.execute(.init())
        switch result {
        case .connected:
            return await downloadItems(input: input)
        case .unavailable:
            // ネットワークに接続されていない場合、ここで処理を終える
            return .success
        }
    }

    /// Firestore からデータを同期する
    private func downloadItems(input: DownloadTodosUseCaseInput) async -> DownloadTodosUseCaseResult {
        do {
            let newItems = try await firestoreRepository.fetchAll()
            return await updateLocalData(input: input, items: newItems)
        } catch {
            return .failed(error)
        }
    }

    private func updateLocalData(input _: DownloadTodosUseCaseInput, items: [Todo]) async -> DownloadTodosUseCaseResult {
        do {
            for item in items {
                try await todoRepository.updateTodoStatus(
                    for: item,
                    with: RegistrationStatus.allCases
                )
            }
            return .success
        } catch {
            return .failed(error)
        }
    }
}
