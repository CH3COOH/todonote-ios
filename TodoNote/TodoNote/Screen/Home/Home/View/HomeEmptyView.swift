//
//  HomeEmptyView.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/07.
//

import SwiftUI

struct HomeEmptyView: View {
    let action: () -> Void

    var body: some View {
        VStack {
            R.image.app_icon.image
                .resizable()
                .frame(width: 120, height: 120)
                .scaledToFit()
                .clipShape(Circle())
                .padding(.bottom, 24)

            R.string.localizable.home_empty.text
                .foregroundColor(Color(uiColor: UIColor.label))
                .font(.system(size: 17, weight: .bold))
                .padding(.bottom, 64)

            Button(action: action) {
                HStack {
                    R.string.localizable.home_button_add.text
                        .foregroundColor(Color.white)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(R.color.accentColor.color)
                )
            }
        }
        .padding(.horizontal, 24)
    }
}

struct HomeEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        HomeEmptyView {}
    }
}
