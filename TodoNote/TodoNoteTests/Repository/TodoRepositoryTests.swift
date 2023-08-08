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

    func testCreateAndDelete_1() async throws {
        try await repository.deleteAll()
        
        let date = Date()
        
        let todo1 = Todo(
            todoId: TodoId(rawValue: "test1"),
            status: RegistrationStatus.ready,
            title: "タイトル",
            body: "本文",
            datetime: date,
            createdAt: date,
            updatedAt: date,
            finished: false
        )
        
        try await repository.addOrUpdate(object: todo1)
        
        let count1 = try repository.fetchCount()
        
        XCTAssertEqual(count1, 1)
        
        try await repository.deleteAll()
        
        let count2 = try repository.fetchCount()

        XCTAssertEqual(count2, 0)
    }

    func testCreateAndDelete_2() async throws {
        try await repository.deleteAll()
        
        let date = Date()
        
        let todo1 = Todo(
            todoId: TodoId(rawValue: "test1"),
            status: RegistrationStatus.ready,
            title: "タイトル",
            body: "本文",
            datetime: date,
            createdAt: date,
            updatedAt: date,
            finished: false
        )
        
        let todo2 = Todo(
            todoId: TodoId(rawValue: "test2"),
            status: RegistrationStatus.ready,
            title: "タイトル",
            body: "本文",
            datetime: date,
            createdAt: date,
            updatedAt: date,
            finished: false
        )
        
        try await repository.addOrUpdate(object: todo1)
        try await repository.addOrUpdate(object: todo2)
        
        let count1 = try repository.fetchCount()
        
        XCTAssertEqual(count1, 2)
        
        try await repository.deleteAll()
        
        let count2 = try repository.fetchCount()

        XCTAssertEqual(count2, 0)
    }
    
    func testCreateAndDelete_3() async throws {
        try await repository.deleteAll()
        
        let date = Date()
        
        let todo1 = Todo(
            todoId: TodoId(rawValue: "test1"),
            status: RegistrationStatus.editing,
            title: "タイトル",
            body: "本文",
            datetime: date,
            createdAt: date,
            updatedAt: date,
            finished: false
        )
        
        let todo2 = Todo(
            todoId: TodoId(rawValue: "test1"),
            status: RegistrationStatus.ready,
            title: "タイトル1",
            body: "本文2",
            datetime: date,
            createdAt: date,
            updatedAt: date,
            finished: false
        )
        
        try await repository.addOrUpdate(object: todo1)
        try await repository.addOrUpdate(object: todo2)
        
        let count1 = try repository.fetchCount()
        
        XCTAssertEqual(count1, 1)
        
        try await repository.deleteAll()
        
        let count2 = try repository.fetchCount()

        XCTAssertEqual(count2, 0)
    }
    
    func testCreateAndGet_1() async throws {
        try await repository.deleteAll()
        
        let todoId = TodoId(rawValue: "test1")
        let date = Date()
        
        let todo1 = Todo(
            todoId: todoId,
            status: RegistrationStatus.ready,
            title: "タイトル",
            body: "本文",
            datetime: date,
            createdAt: date,
            updatedAt: date,
            finished: false
        )
        
        try await repository.addOrUpdate(object: todo1)
        
        let todos = try await repository.fetch(id: todoId)
        
        XCTAssertEqual(todos.count, 1)
        XCTAssertEqual(todos.first?.id, todoId)
        XCTAssertEqual(todos.first?.status, RegistrationStatus.ready)
        XCTAssertEqual(todos.first?.title, "タイトル")
        XCTAssertEqual(todos.first?.description, "本文")

        try await repository.deleteAll()
        
        let count2 = try repository.fetchCount()

        XCTAssertEqual(count2, 0)
    }
    
    func testCreateAndGet_2() async throws {
        try await repository.deleteAll()
        
        let todoId = TodoId(rawValue: "test1")
        let date = Date()
        
        // 1回目
        let todo1 = Todo(
            todoId: todoId,
            status: RegistrationStatus.editing,
            title: "タイトル",
            body: "本文",
            datetime: date,
            createdAt: date,
            updatedAt: date,
            finished: false
        )
        
        try await repository.addOrUpdate(object: todo1)
        
        let todos1 = try await repository.fetch(id: todoId)
        
        XCTAssertEqual(todos1.count, 1)
        XCTAssertEqual(todos1.first?.id, todoId)
        XCTAssertEqual(todos1.first?.status, RegistrationStatus.editing)
        XCTAssertEqual(todos1.first?.title, "タイトル")
        XCTAssertEqual(todos1.first?.description, "本文")

        // 2回目：上書き
        let todo2 = Todo(
            todoId: todoId,
            status: RegistrationStatus.ready,
            title: "Title",
            body: "Body",
            datetime: date,
            createdAt: date,
            updatedAt: date,
            finished: false
        )
        
        try await repository.addOrUpdate(object: todo2)
        
        let todos2 = try await repository.fetch(id: todoId)
        
        XCTAssertEqual(todos2.count, 1)
        XCTAssertEqual(todos2.first?.id, todoId)
        XCTAssertEqual(todos2.first?.status, RegistrationStatus.ready)
        XCTAssertEqual(todos2.first?.title, "Title")
        XCTAssertEqual(todos2.first?.description, "Body")

        // 削除
        try await repository.deleteAll()
        
        let count2 = try repository.fetchCount()

        XCTAssertEqual(count2, 0)
    }
}
