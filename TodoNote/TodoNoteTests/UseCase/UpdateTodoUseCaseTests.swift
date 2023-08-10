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
    
    func test新規作成() async throws {
        try await todoRepository.deleteAll()
        
        let id = TodoId(rawValue: "test1")
        let date = Date()
        
        let input = UpdateTodoUseCaseInput(
            todoId: id,
            title: "タイトル",
            description: "本文",
            datetime: date
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
    }
}
