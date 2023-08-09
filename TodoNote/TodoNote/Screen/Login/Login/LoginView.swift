//
//  LoginView.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/07.
//

import SwiftUI

/// A-2    ログイン
struct LoginView: View {
    @ObservedObject private var model = LoginViewModel()

    @State private var rotation = Angle(degrees: 0)

    var body: some View {
        VStack {
            Color.clear.frame(height: 16)

            R.image.app_icon.image
                .resizable()
                .frame(width: 200, height: 200)
                .scaledToFit()
                .clipShape(Circle())
                .rotationEffect(rotation)
                .onAppear {
                    withAnimation(
                        Animation
                            .linear(duration: 4)
                            .repeatForever(autoreverses: false)
                    ) {
                        rotation = Angle(degrees: 360)
                    }
                }

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
                action: model.onClickLoginButton
            )

            Color.clear.frame(height: 16)
        }
        .padding(.horizontal, 24)
        .alert(item: $model.alertItem) { $0.alert }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
