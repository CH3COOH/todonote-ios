//
//  LaunchUseCase.swift
//
//  Created by KENJIWADA on 2023/03/10.
//

import FirebaseAuth
import Foundation

class LaunchUseCase: UseCaseProtocol {
    let todoRepository: TodoRepository

    let checkVersionUseCase = CheckVersionUseCase()

    init(todoRepository: TodoRepository = TodoRepository()) {
        self.todoRepository = todoRepository
    }

    func execute(_: LaunchUseCaseInput) async -> LaunchUseCaseResult {
        return await deleteEditingItems()
    }

    private func deleteEditingItems() async -> LaunchUseCaseResult {
        do {
            try await todoRepository.deleteAll(status: RegistrationStatus.editing)
        } catch {
            // エラーは無視する
        }
        return await checkLoggedIn()
    }

    private func checkLoggedIn() async -> LaunchUseCaseResult {
        // ログイン状態を調べる
        if Auth.auth().currentUser == nil {
            return .moveToWalkthrough
        }

        return await checkVersion()
    }

    private func checkVersion() async -> LaunchUseCaseResult {
        let result = await checkVersionUseCase.execute(CheckVersionUseCaseInput())
        switch result {
        case .notUpdate:
            return .moveToHome
        case .showVersionInformation:
            return .moveToVersionInformation
        }
    }
}
