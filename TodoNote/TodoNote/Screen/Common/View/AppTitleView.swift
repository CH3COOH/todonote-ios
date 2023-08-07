//
//  AppTitleView.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/07.
//

import SwiftUI

struct AppTitleView: View {
    var body: some View {
        HStack(spacing: 8) {
            R.image.app_icon.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 28, height: 28)
                .clipShape(RoundedRectangle(cornerRadius: 6))

            Text(R.string.localizable.home_title)
                .font(.system(size: 20, weight: .bold))
        }
    }
}

struct AppTitleView_Previews: PreviewProvider {
    static var previews: some View {
        AppTitleView()
    }
}
