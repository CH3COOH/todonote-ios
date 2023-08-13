import FirebaseAuth
import FirebaseAuthUI
import FirebaseEmailAuthUI
import SwiftUI

struct FirebaseUIView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UINavigationController

    class Coordinator: NSObject, FUIAuthDelegate {
        let parent: FirebaseUIView
        init(_ parent: FirebaseUIView) {
            self.parent = parent
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UINavigationController {
        let authUI = FUIAuth.defaultAuthUI()!
        let providers: [FUIAuthProvider] = [
            FUIEmailAuth(),
        ]
        authUI.providers = providers
        authUI.delegate = context.coordinator
        return authUI.authViewController()
    }

    func updateUIViewController(_: UINavigationController, context _: Context) {}
}
