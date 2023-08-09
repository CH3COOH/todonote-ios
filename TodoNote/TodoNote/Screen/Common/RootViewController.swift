//
//  RootViewController.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/07.
//

import UIKit

final class RootViewController: UIViewController {
    private var current = UIViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        current = UIViewController.hostingController {
            SplashView()
        }
        addChild(current)
        current.view.frame = view.bounds
        view.addSubview(current.view)
        current.didMove(toParent: self)
    }

    func switchToHomeScreen() {
        let vc = UINavigationController(
            rootViewController: UIViewController.hostingController {
                HomeView()
            }
        )
        animateFadeTransition(to: vc)
    }

    func switchToLoginScreen() {
        let vc = UINavigationController(
            rootViewController: UIViewController.hostingController {
                LoginView()
            }
        )
        vc.isNavigationBarHidden = true
        animateFadeTransition(to: vc)
    }

    // メイン画面に遷移する際のアニメーションメソッド
    private func animateFadeTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
        current.willMove(toParent: nil)
        addChild(new)
        // ページ遷移
        transition(from: current, to: new, duration: 0.3, options: [.transitionCrossDissolve, .curveEaseOut], animations: {}) { _ in
            self.current.removeFromParent()
            new.didMove(toParent: self)
            self.current = new
            // 完了
            completion?()
        }
    }
}
