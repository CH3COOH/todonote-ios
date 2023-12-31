//
//  FetchTodoListUseCaseResult.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/09.
//

import Foundation

enum FetchTodoListUseCaseResult {
    /// 成功
    case success([TodoSection])

    /// 失敗
    case failed(Error)
}
