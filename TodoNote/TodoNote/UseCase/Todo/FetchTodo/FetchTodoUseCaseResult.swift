//
//  FetchTodoUseCaseResult.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/09.
//

import Foundation

enum FetchTodoUseCaseResult {
    /// 成功
    case success(Todo)

    /// 失敗
    case failed(Error)
}
