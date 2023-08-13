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

    private let syncBackendTodoUseCase = SyncBackendTodoUseCase()

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
                    self.syncBackend()
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

    private func syncBackend() {
        KRProgressHUD.show()
        defer {
            KRProgressHUD.dismiss()
        }
        Task {
            // バックエンド上に存在するタスクの取得
            let result = await syncBackendTodoUseCase.execute(.init())
            switch result {
            case .success:
                await self.moveNextScreen()

            case let .failed(error):
                try! Auth.auth().signOut()
                await show(error: error)
            }
        }
    }

    @MainActor
    private func moveNextScreen() {
        SceneDelegate.shared?.rootViewController.switchToHomeScreen()
    }
}
