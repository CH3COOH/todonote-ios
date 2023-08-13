//
//  LoginViewModel.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/08.
//

import FirebaseAuth
import FirebaseAuthUI
import KRProgressHUD
import SwiftUI

class LoginViewModel: BaseViewModel {
    @Published var isShowSheet = false

    private var listener: AuthStateDidChangeListenerHandle!

    deinit {
        Auth.auth().removeStateDidChangeListener(listener)
        listener = nil
    }

    func onAppear(from _: UIViewController?) {
        if listener == nil {
            listener = Auth.auth().addStateDidChangeListener { _, user in
                if let currentUser = user {
                    if currentUser.isAnonymous {
                        print("sign-in: Anonymous User!")
                    } else {
                        print("sign-in")
                    }
                    self.hogehoge()
                }
            }
        }
    }

    func onClickLoginButton() {
        Task {
            do {
                let center = UNUserNotificationCenter.current()
                try await center.requestAuthorization(options: [.sound, .sound])

                await MainActor.run {
                    isShowSheet = true
                }
            } catch {
                await show(error: error)
            }
        }
    }
    
    private func hogehoge() {
        KRProgressHUD.show()
        defer {
            KRProgressHUD.dismiss()
        }
        Task {
            // バックエンド上に存在するタスクの取得
            
            await self.moveNextScreen()
        }
    }

    @MainActor
    private func moveNextScreen() {
        SceneDelegate.shared?.rootViewController.switchToHomeScreen()
    }
}
