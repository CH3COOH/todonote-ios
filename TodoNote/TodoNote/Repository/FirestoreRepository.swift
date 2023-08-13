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

    private let isTesting: Bool

    init(isTesting: Bool = false) {
        self.isTesting = isTesting
    }

    func addOrUpdate(object: Todo) async throws {
        if isTesting {
            // TODO: DIした方が良い気がするけど将来的に考える
            return
        }

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

    func fetchAll() async throws -> [Todo] {
        if isTesting {
            // TODO: DIした方が良い気がするけど将来的に考える
            return []
        }

        guard let userId = Auth.auth().currentUser?.uid else {
            fatalError("UserId が取得できない")
        }

        let collectionRef = firestore.collection("version/1/users/\(userId)/items")
        let snapshot = try await collectionRef.getDocuments()

        let todos: [Todo] = snapshot.documents
            .compactMap { document -> Todo? in
                let data = document.data()

                guard
                    let todoId = data["id"] as? String,
                    let title = data["title"] as? String,
                    let description = data["desc"] as? String,
                    let datetime = parseDate(data["datetime"]),
                    let createdAt = parseDate(data["create_at"]),
                    let updatedAt = parseDate(data["update_at"])
                else {
                    return nil
                }
                return Todo(
                    todoId: TodoId(rawValue: todoId),
                    status: .complete,
                    title: title,
                    description: description,
                    datetime: datetime,
                    createdAt: createdAt,
                    updatedAt: updatedAt,
                    finished: false
                )
            }

        return todos
    }

    func delete(object: Todo) async throws {
        if isTesting {
            // TODO: DIした方が良い気がするけど将来的に考える
            return
        }

        guard let userId = Auth.auth().currentUser?.uid else {
            fatalError("UserId が取得できない")
        }

        let collectionRef = firestore.collection("version/1/users/\(userId)/items")
        let documentRef = collectionRef.document(object.todoId.rawValue)
        try await documentRef.delete()
    }

    private func parseDate(_ object: Any?) -> Date? {
        if let value = object as? Timestamp {
            return value.dateValue()
        } else if let value = object as? Date {
            return value
        } else {
            return nil
        }
    }
}
