//
//  TodoSection.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/12.
//

import SwiftUI

struct TodoSection {
    let title: String
    let todos: [Todo]
}

extension TodoSection: Identifiable, Hashable {
    var id: String {
        title
    }

    public func hash(into hasher: inout Hasher) {
        return hasher.combine(title)
    }

    static func == (lhs: TodoSection, rhs: TodoSection) -> Bool {
        lhs.id < rhs.id
    }
}
