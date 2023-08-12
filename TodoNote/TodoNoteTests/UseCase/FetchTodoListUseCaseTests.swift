//
//  FetchTodoListUseCaseTests.swift
//  TodoNoteTests
//
//  Created by KENJIWADA on 2023/08/12.
//

import XCTest
@testable import TodoNote

final class FetchTodoListUseCaseTests: XCTestCase {
    
    private var todoRepository: TodoRepository!
    private var useCase: FetchTodoListUseCase!
    
    override func setUpWithError() throws {
        let context = PersistenceController.preview.managedObjectContext
        todoRepository = TodoRepository(context: context)
        useCase = FetchTodoListUseCase(
            todoRepository: todoRepository
        )
    }
    
    override func tearDownWithError() throws {
    }
    
    func test登録() async throws {
        try await todoRepository.deleteAll()
        
        // TODO: ここで良い感じに TODO を作成
        
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
        
        let input = FetchTodoListUseCaseInput(
            sortType: .hogehoge
        )
        let result = await useCase.execute(input)
        switch result {
        case let .success(group):
            break
        case let .failed(error):
            XCTFail(error.localizedDescription)
        }
        
        let count1 = try todoRepository.fetchCount()
        
        XCTAssertEqual(count1, 3)
        
        try await todoRepository.deleteAll()
    }
}
