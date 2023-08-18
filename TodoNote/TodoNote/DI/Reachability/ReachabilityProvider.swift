//
//  ReachabilityProvider.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/18.
//

import Reachability

struct ReachabilityProvider: ReachabilityProviderProtocol {
    func isConnected() throws -> Bool {
        let reachability = try Reachability()
        switch reachability.connection {
        case .unavailable, .none:
            return false
        case .cellular, .wifi:
            return true
        }
    }
}
