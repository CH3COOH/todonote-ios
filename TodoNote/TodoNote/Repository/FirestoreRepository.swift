//
//  FirestoreRepository.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/10.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class FirestoreRepository {
    private let auth = Auth.auth()

    private let firestore = Firestore.firestore()

    func addOrUpdate(object: Todo) async throws {
        guard let userId = Auth.auth().currentUser?.uid else {
            fatalError("UserId が取得できない")
        }

        let collectionRef = firestore.collection("version/1/users/\(userId)/items")
        let documentRef = collectionRef.document(object.todoId.rawValue)
        try await documentRef.setData(
            [
                "id": object.todoId.rawValue,
                "title": object.title,
                "desc": object.description ?? "",
                "datetime": object.datetime,
                "create_at": object.createdAt,
                "update_at": object.updatedAt,
            ]
        )
    }

    func delete(object: Todo) async throws {
        guard let userId = Auth.auth().currentUser?.uid else {
            fatalError("UserId が取得できない")
        }

        let collectionRef = firestore.collection("version/1/users/\(userId)/items")
        let documentRef = collectionRef.document(object.todoId.rawValue)
        try await documentRef.delete()
    }
}
