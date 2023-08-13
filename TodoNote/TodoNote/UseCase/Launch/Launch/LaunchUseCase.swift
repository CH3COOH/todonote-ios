//
//  LaunchUseCase.swift
//
//  Created by KENJIWADA on 2023/03/10.
//

import FirebaseAuth
import Foundation

class LaunchUseCase: UseCaseProtocol {
    let todoRepository: TodoRepository

    let checkVersionUseCase: CheckVersionUseCase

    let syncReadyTodoUseCase: SyncReadyTodoUseCase

    init(
        todoRepository: TodoRepository = TodoRepository(),
        checkVersionUseCase: CheckVersionUseCase = CheckVersionUseCase(),
        syncReadyTodoUseCase: SyncReadyTodoUseCase = SyncReadyTodoUseCase()
    ) {
        self.todoRepository = todoRepository
        self.checkVersionUseCase = checkVersionUseCase
        self.syncReadyTodoUseCase = syncReadyTodoUseCase
    }

    func execute(_: LaunchUseCaseInput) async -> LaunchUseCaseResult {
        return await deleteEditingItems()
    }

    private func deleteEditingItems() async -> LaunchUseCaseResult {
        do {
            // TODO: 将来的には、このタイミングで検出した editing レコードの再編集をおこなう
            try await todoRepository.delete(with: [.editing])
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

        return await syncReadyTodo()
    }

    private func syncReadyTodo() async -> LaunchUseCaseResult {
        let result = await syncReadyTodoUseCase.execute(.init())
        switch result {
        case .success:
            return await checkVersion()
        case .failed:
            return await checkVersion()
        }
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
