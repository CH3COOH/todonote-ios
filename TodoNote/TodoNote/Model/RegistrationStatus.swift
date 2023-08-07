//
//  RegistrationStatus.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/07.
//

import Foundation

enum RegistrationStatus: String {
    case new
    case editing
    case ready
    case complete
}

extension RegistrationStatus {
    func from(value: String) -> RegistrationStatus {
        switch value {
        case RegistrationStatus.new.rawValue:
            return .new
        case RegistrationStatus.editing.rawValue:
            return .new
        case RegistrationStatus.ready.rawValue:
            return .new
        case RegistrationStatus.complete.rawValue:
            return .new
        default:
            fatalError("value が不正である")
        }
    }
}
