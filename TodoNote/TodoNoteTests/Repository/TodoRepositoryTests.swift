//
//  TodoRepositoryTests.swift
//  TodoNoteTests
//
//  Created by KENJIWADA on 2023/08/09.
//

import XCTest
@testable import TodoNote

final class TodoRepositoryTests: XCTestCase {

    private var repository: TodoRepository!
    
    override func setUpWithError() throws {
        repository = TodoRepository(context: PersistenceController.preview.managedObjectContext)
    }

    override func tearDownWithError() throws {
    }

    func testInsert_1() async throws {
        try await repository.delete(with: RegistrationStatus.allCases)
        
        let id = TodoId(rawValue: "test1")
        let date = Date()
        
        let todo = Todo(
            todoId: id,
            status: .ready,
            title: "タイトル",
            description: "本文",
            datetime: date,
            createdAt: date,
            updatedAt: date,
            finished: false
        )
        
        try await repository.insert(for: todo)
        
        let count1 = try repository.fetchCount()
        
        XCTAssertEqual(count1, 1)
        
        let fetchedTodo = try await repository.fetch(by: id)
        
        XCTAssertNotNil(fetchedTodo)
        XCTAssertEqual(fetchedTodo!.id, id)
        XCTAssertEqual(fetchedTodo!.todoId, id)
        XCTAssertEqual(fetchedTodo!.status, RegistrationStatus.ready)
        XCTAssertEqual(fetchedTodo!.title, "タイトル")
        XCTAssertEqual(fetchedTodo!.description, "本文")
        XCTAssertEqual(fetchedTodo!.finished, false)
        
        try await repository.delete(by: id)

        let count2 = try repository.fetchCount()
        
        XCTAssertEqual(count2, 0)
    }
    
    func testDelete_1() async throws {
        try await repository.delete(with: RegistrationStatus.allCases)
        
        let id = TodoId(rawValue: "test1")
        
        let todo1 = Todo(
            todoId: id,
            status: .editing,
            title: "タイトル1",
            description: "本文1",
            datetime: Date(),
            createdAt: Date(),
            updatedAt: Date(),
            finished: false
        )
        
        let todo2 = Todo(
            todoId: id,
            status: .ready,
            title: "タイトル2",
            description: "本文2",
            datetime: Date(),
            createdAt: Date(),
            updatedAt: Date(),
            finished: false
        )
        
        try await repository.insert(for: todo1)
        try await repository.insert(for: todo2)
        
        let count1 = try repository.fetchCount()
        
        XCTAssertEqual(count1, 2)
        
        try await repository.delete(by: id, with: [.editing])
        
        let count2 = try repository.fetchCount()
        
        XCTAssertEqual(count2, 1)

        try await repository.delete(by: id)
        
        let count3 = try repository.fetchCount()
        
        XCTAssertEqual(count3, 0)
    }
    
    func testFetch_1() async throws {
        try await repository.delete(with: RegistrationStatus.allCases)
        
        let id = TodoId(rawValue: "test1")
        
        let todo1 = Todo(
            todoId: id,
            status: .editing,
            title: "タイトル1",
            description: "本文1",
            datetime: Date(),
            createdAt: Date(),
            updatedAt: Date(),
            finished: false
        )
        
        let todo2 = Todo(
            todoId: id,
            status: .ready,
            title: "タイトル2",
            description: "本文2",
            datetime: Date(),
            createdAt: Date(),
            updatedAt: Date(),
            finished: false
        )
        
        try await repository.insert(for: todo1)
        try await repository.insert(for: todo2)
        
        let results1 = try await repository.fetch(by: id, with: [.editing])
        XCTAssertNotNil(results1)
        
        try await repository.delete(by: id, with: [.editing])
        
        let results2 = try await repository.fetch(by: id, with: [.editing])
        XCTAssertNil(results2)

        try await repository.delete(with: RegistrationStatus.allCases)
    }
    
    func testCreateAndDelete_1() async throws {
        try await repository.delete(with: RegistrationStatus.allCases)
        
        let date = Date()
        
        let todo1 = Todo(
            todoId: TodoId(rawValue: "test1"),
            status: RegistrationStatus.ready,
            title: "タイトル",
            description: "本文",
            datetime: date,
            createdAt: date,
            updatedAt: date,
            finished: false
        )
        
        try await repository.insert(for: todo1)
        
        let count1 = try repository.fetchCount()
        
        XCTAssertEqual(count1, 1)
        
        try await repository.delete(with: RegistrationStatus.allCases)
        
        let count2 = try repository.fetchCount()

        XCTAssertEqual(count2, 0)
    }

    func testCreateAndDelete_2() async throws {
        try await repository.delete(with: RegistrationStatus.allCases)
        
        let date = Date()
        
        let todo1 = Todo(
            todoId: TodoId(rawValue: "test1"),
            status: RegistrationStatus.ready,
            title: "タイトル",
            description: "本文",
            datetime: date,
            createdAt: date,
            updatedAt: date,
            finished: false
        )
        
        let todo2 = Todo(
            todoId: TodoId(rawValue: "test2"),
            status: RegistrationStatus.ready,
            title: "タイトル",
            description: "本文",
            datetime: date,
            createdAt: date,
            updatedAt: date,
            finished: false
        )
        
        try await repository.insert(for: todo1)
        try await repository.insert(for: todo2)
        
        let count1 = try repository.fetchCount()
        
        XCTAssertEqual(count1, 2)
        
        try await repository.delete(with: RegistrationStatus.allCases)
        
        let count2 = try repository.fetchCount()

        XCTAssertEqual(count2, 0)
    }
    
    func testCreateAndGet_1() async throws {
        try await repository.delete(with: RegistrationStatus.allCases)
        
        let todoId = TodoId(rawValue: "test1")
        let date = Date()
        
        let todo1 = Todo(
            todoId: todoId,
            status: RegistrationStatus.ready,
            title: "タイトル",
            description: "本文",
            datetime: date,
            createdAt: date,
            updatedAt: date,
            finished: false
        )
        
        try await repository.insert(for: todo1)
        
        let todos = try await repository.fetch(by: todoId)
        
        XCTAssertEqual(todos?.id, todoId)
        XCTAssertEqual(todos?.status, RegistrationStatus.ready)
        XCTAssertEqual(todos?.title, "タイトル")
        XCTAssertEqual(todos?.description, "本文")

        try await repository.delete(with: RegistrationStatus.allCases)
        
        let count2 = try repository.fetchCount()

        XCTAssertEqual(count2, 0)
        
        try await repository.delete(with: RegistrationStatus.allCases)
    }
    
    func testCreateAndGet_2() async throws {
        try await repository.delete(with: RegistrationStatus.allCases)
        
        let todoId = TodoId(rawValue: "test1")
        let date = Date()
        
        // 1回目
        let todo1 = Todo(
            todoId: todoId,
            status: .editing,
            title: "タイトル",
            description: "本文",
            datetime: date,
            createdAt: date,
            updatedAt: date,
            finished: false
        )
        
        try await repository.insert(for: todo1)
        
        let todos1 = try await repository.fetch(by: todoId)

        XCTAssertNotNil(todos1)
        XCTAssertEqual(todos1?.id, todoId)
        XCTAssertEqual(todos1?.status, RegistrationStatus.editing)
        XCTAssertEqual(todos1?.title, "タイトル")
        XCTAssertEqual(todos1?.description, "本文")

        // 2回目：上書き
        let todo2 = todo1.copy(
            status: .ready,
            title: "Title",
            description: "Body"
        )
        
        try await repository.updateTodoStatus(for: todo2, with: [.editing])
        
        let todos2 = try await repository.fetch(by: todoId)
        
        XCTAssertEqual(todos2?.id, todoId)
        XCTAssertEqual(todos2?.status, RegistrationStatus.ready)
        XCTAssertEqual(todos2?.title, "Title")
        XCTAssertEqual(todos2?.description, "Body")

        // 削除
        try await repository.delete(with: RegistrationStatus.allCases)
        
        let count2 = try repository.fetchCount()

        XCTAssertEqual(count2, 0)
    }
}
