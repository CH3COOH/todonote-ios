//
//  LoginView.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/07.
//

import FirebaseAuth
import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack {
            R.image.app_icon.image
                .resizable()
                .frame(width: 200, height: 200)
                .scaledToFit()
                .clipShape(Circle())

            R.string.localizable.login_title.text
                .foregroundColor(Color(uiColor: UIColor.label))
                .font(.system(size: 24, weight: .bold))
                .padding(.top, 16)

            R.string.localizable.login_body.text
                .multilineTextAlignment(.center)
                .lineSpacing(6)
                .foregroundColor(Color(uiColor: UIColor.label))
                .font(.system(size: 15, weight: .regular))
                .padding(.top, 24)

            Spacer()

            AccentButton(
                title: R.string.localizable.login_button.text,
                action: onClickLoginButton
            )

            Color.clear.frame(height: 16)
        }
        .padding(.horizontal, 24)
        .alert(item: $alert) { $0.alert }
    }

    @State private var alert: AlertItem?

    private func onClickLoginButton() {
        Task {
            do {
                let center = UNUserNotificationCenter.current()
                try await center.requestAuthorization(options: [.sound, .sound])

                try await Auth.auth().signInAnonymously()

                await moveNextScreen()
            } catch {
                alert = AlertItem(
                    alert: Alert(
                        title: Text("Error!")
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
