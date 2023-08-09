//
//  CheckVersionUseCaseResult.swift
//
//  Created by KENJIWADA on 2023/01/03.
//  Copyright © 2023 KENJI WADA. All rights reserved.
//

import Foundation

enum CheckVersionUseCaseResult {
    /// 初回起動・またはアップデートしていない
    case notUpdate

    /// アップデート後の初回起動である
    case showVersionInformation
}
