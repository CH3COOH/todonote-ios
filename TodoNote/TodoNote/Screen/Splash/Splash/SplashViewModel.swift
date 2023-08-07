//
//  SplashViewModel.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/07.
//

import Foundation
import SwiftUI

class SplashViewModel: ObservableObject {
    private var result = LaunchUseCaseResult.moveToHome

    private let launchUseCase = LaunchUseCase()

    func onAppear(from _: UIViewController?) {
        Task {
            defer {
                DispatchQueue.main.async {
                    self.moveNextScreen()
                }
            }

            self.result = await launchUseCase.execute(LaunchUseCaseInput())
        }
    }

    private func moveNextScreen() {
        switch result {
        case .moveToHome:
            SceneDelegate.shared?.rootViewController.switchToHomeScreen()
        case .moveToWalkthrough:
//            SceneDelegate.shared?.rootViewController.switchToWalkthroughScreen()
            SceneDelegate.shared?.rootViewController.switchToHomeScreen()
        case .moveToVersionInformation:
//            SceneDelegate.shared?.rootViewController.switchToVersionInformationScreen()
            SceneDelegate.shared?.rootViewController.switchToHomeScreen()
        }
    }
}
