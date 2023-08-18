//
//  SignOutUseCaseTests.swift
//  TodoNoteTests
//
//  Created by KENJIWADA on 2023/08/18.
//

import XCTest
@testable import TodoNote

final class SignOutUseCaseTests: XCTestCase {
    
    private var todoRepository: TodoRepository!
    private var useCase: SignOutUseCase!
    
    override func setUpWithError() throws {
        let context = PersistenceController.preview.managedObjectContext
        todoRepository = TodoRepository(context: context)
        let uploadReadyTodosUseCase = UploadReadyTodosUseCase(
            firestoreRepository: FirestoreRepository(isTesting: true),
            todoRepository: todoRepository,
            checkNetworkAccessUseCase: CheckNetworkAccessUseCase(
                reachabilityProvider: MockReachabilityProvider(connected: true)
            )
    
        )
        useCase = SignOutUseCase(
            todoRepository: todoRepository,
            authProvider: MockAuthProvider(),
            syncReadyTodoUseCase: uploadReadyTodosUseCase
        )
    }
    
    override func tearDownWithError() throws {
    }
    
    func test_1() async throws {
        let result = await useCase.execute(.init())
        switch result {
        case .success:
            break
        case let .failed(error):
            XCTFail(error.localizedDescription)
        }
    }
}

