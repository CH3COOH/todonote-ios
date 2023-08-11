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
    let description: String?
    let datetime: Date
    let createdAt: Date
    let updatedAt: Date
    let finished: Bool

    func copy(
        todoId: TodoId? = nil,
        status: RegistrationStatus? = nil,
        title: String? = nil,
        description: String? = nil,
        datetime: Date? = nil,
        createdAt: Date? = nil,
        updatedAt: Date? = nil,
        finished: Bool? = nil
    ) -> Todo {
        return Todo(
            todoId: todoId ?? self.todoId,
            status: status ?? self.status,
            title: title ?? self.title,
            description: description ?? self.description,
            datetime: datetime ?? self.datetime,
            createdAt: createdAt ?? self.createdAt,
            updatedAt: updatedAt ?? self.updatedAt,
            finished: finished ?? self.finished
        )
    }
}

extension Todo: Identifiable {
    var id: TodoId {
        todoId
    }
}
