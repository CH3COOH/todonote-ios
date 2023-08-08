//
//  TodoEntity.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/07.
//

import Foundation

extension TodoEntity {
    func toModel() -> Todo? {
        guard
            let id = todo_id,
            let status = status,
            let registrationStatus = RegistrationStatus(rawValue: status),
            let title = title,
            let datetime = datetime,
            let createdAt = created_at,
            let updatedAt = updated_at
        else {
            return nil
        }
        return Todo(
            todoId: TodoId(rawValue: id),
            status: registrationStatus,
            title: title,
            description: body ?? "",
            datetime: datetime,
            createdAt: createdAt,
            updatedAt: updatedAt,
            finished: finished
        )
    }
}
