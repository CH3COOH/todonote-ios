//
//  ReachabilityProviderProtocol.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/18.
//

import Foundation

protocol ReachabilityProviderProtocol {
    func isConnected() throws -> Bool
}
