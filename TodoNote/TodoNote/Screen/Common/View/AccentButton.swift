//
//  AccentButton.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/08.
//

import SwiftUI

struct AccentButton: View {
    let title: Text

    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                title
                    .font(.system(size: 17, weight: .bold))
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
}

struct AccentButton_Previews: PreviewProvider {
    static var previews: some View {
        AccentButton(
            title: Text("追加する")
        ) {}
    }
}
