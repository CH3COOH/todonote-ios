//
//  UploadReadyTodosUseCaseTests.swift
//  TodoNoteTests
//
//  Created by KENJIWADA on 2023/08/18.
//

import XCTest
@testable import TodoNote

final class UploadReadyTodosUseCaseTests: XCTestCase {
    
    private var todoRepository: TodoRepository!
    private var checkNetworkAccessUseCase: CheckNetworkAccessUseCase!
    private var useCase: UploadReadyTodosUseCase!
    
    override func setUpWithError() throws {
        let context = PersistenceController.preview.managedObjectContext
        todoRepository = TodoRepository(context: context)
        checkNetworkAccessUseCase = CheckNetworkAccessUseCase(
            reachabilityProvider: MockReachabilityProvider(connected: true)
        )
        useCase = UploadReadyTodosUseCase(
            firestoreRepository: FirestoreRepository(isTesting: true),
            todoRepository: todoRepository,
            checkNetworkAccessUseCase: checkNetworkAccessUseCase
        )
    }
    
    override func tearDownWithError() throws {
    }
    
    func testアップロード_1() async throws {
        try await todoRepository.delete(with: RegistrationStatus.allCases)
        
        let result = await useCase.execute(.init())
        switch result {
        case .success:
            break
        case .failed:
            XCTFail()
        }
        
        try await todoRepository.delete(with: RegistrationStatus.allCases)
    }
    
    func testアップロード_2() async throws {
        try await todoRepository.delete(with: RegistrationStatus.allCases)
        
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
        
        try await todoRepository.insert(for: todo)
        
        let result = await useCase.execute(.init())
        switch result {
        case .success:
            break
        case .failed:
            XCTFail()
        }
        
        try await todoRepository.delete(with: RegistrationStatus.allCases)
    }
    
    func testアップロード_3() async throws {
        try await todoRepository.delete(with: RegistrationStatus.allCases)
        
        let todo1 = Todo(
            todoId: TodoId(rawValue: "test1"),
            status: .ready,
            title: "タイトル",
            description: "本文",
            datetime: Date(),
            createdAt: Date(),
            updatedAt: Date(),
            finished: false
        )
        try await todoRepository.insert(for: todo1)
        
        let todo2 = Todo(
            todoId: TodoId(rawValue: "test2"),
            status: .ready,
            title: "タイトル",
            description: "本文",
            datetime: Date(),
            createdAt: Date(),
            updatedAt: Date(),
            finished: true
        )
        try await todoRepository.insert(for: todo2)
        
        let result = await useCase.execute(.init())
        switch result {
        case .success:
            break
        case .failed:
            XCTFail()
        }
        
        try await todoRepository.delete(with: RegistrationStatus.allCases)
    }
}

