//
//  LaunchUseCaseResult.swift
//
//  Created by KENJIWADA on 2023/03/10.
//

import Foundation

enum LaunchUseCaseResult {
    /// 通常起動
    case moveToHome

    /// アップデート
    case moveToVersionInformation

    /// 新規起動 (ウォークスルー)
    case moveToWalkthrough
}
