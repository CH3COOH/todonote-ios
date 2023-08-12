//
//  RegistrationStatus.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/07.
//

import Foundation

enum RegistrationStatus: String {
    case editing
    case ready
    case complete
}

extension RegistrationStatus: CaseIterable {
    static var allCases: [RegistrationStatus] {
        [.editing, .ready, .complete]
    }

    func from(value: String) -> RegistrationStatus {
        switch value {
        case RegistrationStatus.editing.rawValue:
            return .editing
        case RegistrationStatus.ready.rawValue:
            return .ready
        case RegistrationStatus.complete.rawValue:
            return .complete
        default:
            fatalError("value が不正である")
        }
    }
}
