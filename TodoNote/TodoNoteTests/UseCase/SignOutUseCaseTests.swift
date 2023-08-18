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
//    private var useCase: SignOutUseCase!
    
    override func setUpWithError() throws {
        let context = PersistenceController.preview.managedObjectContext
        todoRepository = TodoRepository(context: context)
//        useCase = SignOutUseCase(
//            todoRepository: todoRepository,
//            authProvider: MockAuthProvider(),
//            syncReadyTodoUseCase: UploadReadyTodosUseCase()
//        )
    }
    
    override func tearDownWithError() throws {
    }
}

