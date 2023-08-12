//
//  FirebaseAuthProvider.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/12.
//

import FirebaseAuth

class FirebaseAuthProvider: AuthProviderProtocol {
    func signInAnonymously() async throws {
        try await Auth.auth().signInAnonymously()
    }

    func signOut() throws {
        try Auth.auth().signOut()
    }
}
