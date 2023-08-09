//
//  LoginViewModel.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/08.
//

import FirebaseAuth
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var alertItem: AlertItem?

    func onAppear(from _: UIViewController?) {}

    func onClickLoginButton() {
        Task {
            do {
                let center = UNUserNotificationCenter.current()
                try await center.requestAuthorization(options: [.sound, .sound])

                try await Auth.auth().signInAnonymously()

                await moveNextScreen()
            } catch {
                alertItem = AlertItem(
                    alert: Alert(
                        title: R.string.localizable.error.text,
                        message: Text(error.localizedDescription)
                    )
                )
            }
        }
    }

    @MainActor
    private func moveNextScreen() {
        SceneDelegate.shared?.rootViewController.switchToHomeScreen()
    }
}
