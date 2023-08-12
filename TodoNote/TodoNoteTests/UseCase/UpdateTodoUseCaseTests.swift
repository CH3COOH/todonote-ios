//
//  UpdateTodoUseCaseTests.swift
//  TodoNoteTests
//
//  Created by KENJIWADA on 2023/08/10.
//

import XCTest
@testable import TodoNote

final class UpdateTodoUseCaseTests: XCTestCase {
    
    private var firestoreRepository: FirestoreRepository!
    private var todoRepository: TodoRepository!
    private var useCase: UpdateTodoUseCase!
    
    override func setUpWithError() throws {
        todoRepository = TodoRepository(context: PersistenceController.preview.managedObjectContext)
        firestoreRepository = FirestoreRepository(isTesting: true)
        useCase = UpdateTodoUseCase(
            firestoreRepository: firestoreRepository,
            todoRepository: todoRepository
        )
    }
    
    override func tearDownWithError() throws {
    }
    
    func test登録() async throws {
        try await todoRepository.deleteAll(with: RegistrationStatus.allCases)
        
        let todoId = TodoId(rawValue: "test1")
        let date = Date()
        let todo = Todo(
            todoId: todoId,
            status: RegistrationStatus.ready,
            title: "Title",
            description: "Body",
            datetime: date,
            createdAt: date,
            updatedAt: date,
            finished: false
        )
        
        let input = UpdateTodoUseCaseInput(
            todo: todo
        )
        let result = await useCase.execute(input)
        switch result {
        case .success:
            break
        case let .failed(error):
            XCTFail(error.localizedDescription)
        }
        
        let count1 = try todoRepository.fetchCount()

        XCTAssertEqual(count1, 1)
        
        try await todoRepository.deleteAll(with: RegistrationStatus.allCases)
    }
    
    func test編集() async throws {
        try await todoRepository.deleteAll(with: RegistrationStatus.allCases)
        
        let todoId = TodoId(rawValue: "test1")
        let date = Date()
        let todo = Todo(
            todoId: todoId,
            status: RegistrationStatus.ready,
            title: "Title",
            description: "Body",
            datetime: date,
            createdAt: date,
            updatedAt: date,
            finished: false
        )
        
        let input = UpdateTodoUseCaseInput(
            todo: todo
        )
        let result = await useCase.execute(input)
        switch result {
        case .success:
            break
        case let .failed(error):
            XCTFail(error.localizedDescription)
        }
        
        let count1 = try todoRepository.fetchCount()

        XCTAssertEqual(count1, 1)
        
        try await todoRepository.deleteAll(with: RegistrationStatus.allCases)
    }
}
