//
//  TodoId.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/07.
//

import SwiftUI

struct CardId {
    let rawValue: String
}

extension TodoId: Identifiable, Hashable, Comparable {
    var id: String {
        rawValue
    }

    static func == (lhs: TodoId, rhs: TodoId) -> Bool {
        lhs.rawValue == rhs.rawValue
    }

    static func < (lhs: TodoId, rhs: TodoId) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}
