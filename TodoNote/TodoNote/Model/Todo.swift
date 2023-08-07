//
//  Todo.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/07.
//

import Foundation

struct Todo {
    let todoId: TodoId
    let status: RegistrationStatus
    let title: String
    let body: String
    let datetime: Date
    let createdAt: Date
    let updatedAt: Date
    let finished: Bool
}

extension Todo: Identifiable {
    var id: TodoId {
        todoId
    }
}
