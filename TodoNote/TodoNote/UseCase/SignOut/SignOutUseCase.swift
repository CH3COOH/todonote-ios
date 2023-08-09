//
//  SignOutUseCase.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/09.
//

import FirebaseAuth

class SignOutUseCase: UseCaseProctol {
    private let resitory: TodoRepository

    init(resitory: TodoRepository = TodoRepository()) {
        self.resitory = resitory
    }

    func execute(_ input: SignOutUseCaseInput) async -> SignOutUseCaseResult {
        return await syncReadyData(input: input)
    }

    private func syncReadyData(input: SignOutUseCaseInput) async -> SignOutUseCaseResult {
        // TODO: ステータスが `ready` のレコードがあればサーバーに同期する
        return await deleteAllLocalData(input: input)
    }

    /// サインアウトしたのでローカルデータを全削除する
    private func deleteAllLocalData(input: SignOutUseCaseInput) async -> SignOutUseCaseResult {
        do {
            try await resitory.deleteAll()

            return await signOut(input: input)
        } catch {
            return .failed(error)
        }
    }

    private func signOut(input _: SignOutUseCaseInput) async -> SignOutUseCaseResult {
        do {
            try Auth.auth().signOut()

            return .success
        } catch {
            return .failed(error)
        }
    }
}
