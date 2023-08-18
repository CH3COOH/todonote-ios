//
//  MockReachabilityProvider.swift
//  TodoNoteTests
//
//  Created by KENJIWADA on 2023/08/18.
//

import Foundation
@testable import TodoNote

struct MockReachabilityProvider: ReachabilityProviderProtocol {
    let connected: Bool

    func isConnected() throws -> Bool {
        return connected
    }
}
