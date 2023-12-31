//
//  AppError.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/11.
//

import Foundation

enum AppError: Error {
    case invalidContent

    case unknownNetworkState
}

extension AppError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidContent:
            return "ネットワークのアクセス経路に異常がある"
        case .unknownNetworkState:
            return "ネットワーク接続状態に異常がある"
        }
    }
}
