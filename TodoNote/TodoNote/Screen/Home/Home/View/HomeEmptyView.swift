//
//  HomeEmptyView.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/07.
//

import SwiftUI

struct HomeEmptyView: View {
    let action: () -> Void

    @State private var rotation = Angle(degrees: 0)

    var body: some View {
        VStack {
            R.image.app_icon.image
                .resizable()
                .frame(width: 120, height: 120)
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
                .padding(.bottom, 16)

            R.string.localizable.home_empty.text
                .foregroundColor(Color(uiColor: UIColor.label))
                .font(.system(size: 17, weight: .bold))
                .padding(.bottom, 48)

            AccentButton(
                title: R.string.localizable.home_button_add.text,
                action: action
            )

            Color.clear.frame(height: 16)
        }
        .padding(.horizontal, 24)
    }
}

struct HomeEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        HomeEmptyView {}
    }
}
