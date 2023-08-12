//
//  MockAuthProvider.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/12.
//

import Foundation

class MockAuthProvider: AuthProviderProtocol {
    func signInAnonymously() async throws {}
    func signOut() throws {}
}
