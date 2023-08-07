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
                .frame(width: 64, height: 64)
                .scaledToFit()
                .padding(.bottom, 24)

            Text("TODO はまだ登録されていません")
                .foregroundColor(Color(uiColor: UIColor.label))
                .font(.system(size: 17, weight: .bold))
                .padding(.bottom, 64)

            Button(action: action) {
                HStack {
                    Image(systemName: "plus")
                        .foregroundColor(Color.white)
                    Text("最初の TODO を追加する")
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
