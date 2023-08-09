//
//  SignOutUseCase.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/09.
//

import FirebaseAuth

/// BL-S02 ログアウト
class SignOutUseCase: UseCaseProctol {
    private let todoRepository: TodoRepository

    private let syncReadyTodoUseCase: SyncReadyTodoUseCase

    init(
        todoRepository: TodoRepository = TodoRepository(),
        syncReadyTodoUseCase: SyncReadyTodoUseCase = SyncReadyTodoUseCase()
    ) {
        self.todoRepository = todoRepository
        self.syncReadyTodoUseCase = syncReadyTodoUseCase
    }

    func execute(_ input: SignOutUseCaseInput) async -> SignOutUseCaseResult {
        return await syncReadyData(input: input)
    }

    /// ステータスが `ready` のレコードがあればサーバーに同期する
    private func syncReadyData(input: SignOutUseCaseInput) async -> SignOutUseCaseResult {
        let result = await syncReadyTodoUseCase.execute(.init())
        switch result {
        case .success:
            return await deleteAllLocalData(input: input)
        case let .failed(error):
            return .failed(error)
        }
    }

    /// ローカルデータを全削除する
    private func deleteAllLocalData(input: SignOutUseCaseInput) async -> SignOutUseCaseResult {
        do {
            try await todoRepository.deleteAll()

            return await signOut(input: input)
        } catch {
            return .failed(error)
        }
    }

    /// サインアウトする
    private func signOut(input _: SignOutUseCaseInput) async -> SignOutUseCaseResult {
        do {
            try Auth.auth().signOut()

            return .success
        } catch {
            return .failed(error)
        }
    }
}
