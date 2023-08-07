//
//  LaunchUseCase.swift
//
//  Created by KENJIWADA on 2023/03/10.
//

import Foundation

class LaunchUseCase: UseCaseProctol {
    let checkVersionUseCase = CheckVersionUseCase()

    func execute(_: LaunchUseCaseInput) async -> LaunchUseCaseResult {
        return await checkShownWalkthrough()
    }

    private func checkShownWalkthrough() async -> LaunchUseCaseResult {
        // 一度も表示していない場合、ウォークスルーを表示する
        let shownWalkthrough = UserDefaults.standard.bool(forKey: AppConstValues.shown_walkthrough)
        if !shownWalkthrough {
            return .moveToWalkthrough
        }

        return await checkVersion()
    }

    private func checkVersion() async -> LaunchUseCaseResult {
        let result = await checkVersionUseCase.execute(CheckVersionUseCaseInput())
        switch result {
        case .notUpdate:
            return .moveToHome
        case .showVersionInformation:
            return .moveToVersionInformation
        }
    }
}
