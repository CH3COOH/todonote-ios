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

    @State private var scale: CGFloat = 1.0

    var body: some View {
        VStack {
            R.image.app_icon.image
                .resizable()
                .frame(width: 120, height: 120)
                .scaledToFit()
                .clipShape(Circle())
                .rotationEffect(rotation)
                .scaleEffect(scale)
                .onAppear {
                    withAnimation(
                        Animation
                            .linear(duration: 4)
                            .repeatForever(autoreverses: false)
                    ) {
                        rotation = Angle(degrees: 360)
                    }
                }
                .gesture(
                    TapGesture()
                        .onEnded { _ in
                            withAnimation(
                                Animation
                                    .easeInOut(duration: 0.3)
                            ) {
                                scale = 1.2
                            }

                            withAnimation(
                                Animation
                                    .easeInOut(duration: 0.1)
                                    .delay(0.3)
                            ) {
                                scale = 1.0
                            }
                        }
                )
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
