//
//  CheckVersionUseCase.swift
//
//  Created by KENJIWADA on 2023/01/03.
//  Copyright © 2023 KENJI WADA. All rights reserved.
//

import Foundation

/// BL-Z04 アプリバージョンのチェック
class CheckVersionUseCase: UseCaseProtocol {
    func execute(_: CheckVersionUseCaseInput) async -> CheckVersionUseCaseResult {
        return await checkVersion()
    }

    private func checkVersion() async -> CheckVersionUseCaseResult {
        guard let version = bundleShortVersion else {
            return .notUpdate
        }
        guard let beforeVersion = UserDefaults.standard.string(forKey: AppConstValues.current_version) else {
            // 初めての起動だった場合はバージョンを記録して終わり
            UserDefaults.standard.setValue(version, forKey: AppConstValues.current_version)
            return .notUpdate
        }

        let compared = version.compare(beforeVersion)
        switch compared {
        case .orderedSame:
            // 前回の起動時と現在のアプリバージョンが同じ場合は何も表示しない
            print("not update 1: latest:\(version) current:\(beforeVersion)")
            return .notUpdate
        case .orderedAscending:
            print("not update 2: latest:\(version) current:\(beforeVersion)")
            return .notUpdate
        case .orderedDescending:
            print("update!!! latest:\(version) current:\(beforeVersion)")
            UserDefaults.standard.setValue(version, forKey: AppConstValues.current_version)
            return .showVersionInformation
        }
    }

    private var bundleShortVersion: String? {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
}
