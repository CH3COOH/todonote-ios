//
//  LoginView.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/07.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack {
            Button(action: onClickLoginButton) {
                Text("Start this App!")
            }
        }
    }

    private func onClickLoginButton() {
        Task {
            let center = UNUserNotificationCenter.current()
            try await center.requestAuthorization(options: [.sound, .sound])
            await moveNextScreen()
        }
    }

    @MainActor
    private func moveNextScreen() {
        SceneDelegate.shared?.rootViewController.switchToHomeScreen()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
