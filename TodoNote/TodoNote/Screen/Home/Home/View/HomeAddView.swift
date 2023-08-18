//
//  HomeAddView.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/09.
//

import SwiftUI

struct HomeAddView: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack {
                R.image.app_icon.image
                    .resizable()
                    .frame(width: 64, height: 64)
                    .scaledToFit()
                    .clipShape(Circle())
                    .padding(.bottom, 24)

                R.string.localizable.home_new_desc.text
                    .foregroundColor(Color(uiColor: UIColor.label))
                    .font(.system(size: 17, weight: .bold))
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.vertical, 16)
    }
}

struct HomeAddView_Previews: PreviewProvider {
    static var previews: some View {
        HomeAddView(action: {})
    }
}
