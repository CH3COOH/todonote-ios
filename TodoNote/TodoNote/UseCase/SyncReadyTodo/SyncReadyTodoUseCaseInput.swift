//
//  SyncReadyTodoUseCaseInput.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/09.
//

import Foundation

struct SyncReadyTodoUseCaseInput {
    let todoId: TodoId
    let title: String
    let description: String?
    let datetime: Date
}
