//
//  CheckVersionUseCaseTests.swift
//  TodoNoteTests
//
//  Created by KENJIWADA on 2023/08/14.
//

import XCTest
@testable import TodoNote

final class CheckVersionUseCaseTests: XCTestCase {
    
    private var useCase: CheckVersionUseCase!
    
    override func setUpWithError() throws {
        useCase = CheckVersionUseCase()
    }
    
    override func tearDownWithError() throws {
    }
    
    func test初回起動() async throws {
        UserDefaults.standard.removeObject(forKey: AppConstValues.current_version)
        
        let result = await useCase.execute(.init())
        switch result {
        case .notUpdate:
            break
        case .showVersionInformation:
            XCTFail()
        }
    }
    
    func testアップデート不要() async throws {
        guard let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
            XCTFail()
            return
        }

        UserDefaults.standard.setValue(version, forKey: AppConstValues.current_version)
        
        let result = await useCase.execute(.init())
        switch result {
        case .notUpdate:
            break
        case .showVersionInformation:
            XCTFail()
        }
    }
    
    func testアップデート後の初回起動() async throws {
        UserDefaults.standard.setValue("0.0.1", forKey: AppConstValues.current_version)
        
        let result = await useCase.execute(.init())
        switch result {
        case .notUpdate:
            XCTFail()
        case .showVersionInformation:
            break
        }
    }
}

