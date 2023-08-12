//
//  AuthProviderProtocol.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/12.
//

import Foundation

protocol AuthProviderProtocol {
    func signInAnonymously() async throws
    func signOut() throws
}
