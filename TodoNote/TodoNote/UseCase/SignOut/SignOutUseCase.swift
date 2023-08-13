//
//  SignOutUseCase.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/09.
//

import Foundation
import UserNotifications

/// BL-S02 ログアウト
class SignOutUseCase: UseCaseProtocol {
    private let todoRepository: TodoRepository

    private let authProvider: AuthProviderProtocol

    private let syncReadyTodoUseCase: UploadReadyTodosUseCase

    init(
        todoRepository: TodoRepository = TodoRepository(),
        authProvider: AuthProviderProtocol = FirebaseAuthProvider(),
        syncReadyTodoUseCase: UploadReadyTodosUseCase = UploadReadyTodosUseCase()
    ) {
        self.todoRepository = todoRepository
        self.authProvider = authProvider
        self.syncReadyTodoUseCase = syncReadyTodoUseCase
    }

    func execute(_: SignOutUseCaseInput) async -> SignOutUseCaseResult {
        return await syncReadyData()
    }

    private func syncReadyData() async -> SignOutUseCaseResult {
        let result = await syncReadyTodoUseCase.execute(.init())
        switch result {
        case .success:
            return await signOut()
        case let .failed(error):
            return .failed(error)
        }
    }

    private func signOut() async -> SignOutUseCaseResult {
        do {
            try authProvider.signOut()
            return await deleteAllNotificationRequests()
        } catch {
            return .failed(error)
        }
    }

    private func deleteAllNotificationRequests() async -> SignOutUseCaseResult {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        center.removeAllDeliveredNotifications()
        return await deleteAllLocalData()
    }

    private func deleteAllLocalData() async -> SignOutUseCaseResult {
        do {
            try await todoRepository.delete(with: RegistrationStatus.allCases)
        } catch {
            // エラーは無視する
            print(error.localizedDescription)
        }
        return .success
    }
}
