//
//  CheckNetworkAccessUseCaseTests.swift
//  TodoNoteTests
//
//  Created by KENJIWADA on 2023/08/18.
//

import XCTest
@testable import TodoNote

final class CheckNetworkAccessUseCaseTests: XCTestCase {
    
    override func setUpWithError() throws {
    }
    
    override func tearDownWithError() throws {
    }
    
    func testネットワーク接続済み() async throws {
        let useCase = CheckNetworkAccessUseCase(
            reachabilityProvider: MockReachabilityProvider(connected: true)
        )

        let result = await useCase.execute(.init())
        switch result {
        case .connected:
            break
        case .unavailable:
            XCTFail()
        }
    }
    
    func testネットワーク未接続() async throws {
        let useCase = CheckNetworkAccessUseCase(
            reachabilityProvider: MockReachabilityProvider(connected: false)
        )

        let result = await useCase.execute(.init())
        switch result {
        case .connected:
            XCTFail()
        case .unavailable:
            break
        }
    }
}

