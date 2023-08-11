//
//  FirebaseAuthProvider.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/12.
//

import FirebaseAuth

class FirebaseAuthProvider: AuthProviderProtocol {
    func signOut() throws {
        try Auth.auth().signOut()
    }
}
