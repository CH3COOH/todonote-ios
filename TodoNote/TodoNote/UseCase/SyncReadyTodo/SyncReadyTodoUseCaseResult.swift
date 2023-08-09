//
//  SyncReadyTodoUseCaseResult.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/09.
//

import Foundation

enum SyncReadyTodoUseCaseResult {
    /// 成功
    case success

    /// 失敗
    case failed(Error)
}