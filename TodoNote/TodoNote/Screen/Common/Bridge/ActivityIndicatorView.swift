//
//  ActivityIndicatorView.swift
//
//  Created by KENJIWADA on 2023/03/10.
//

import SwiftUI

struct ActivityIndicatorView: UIViewRepresentable {
    let style: UIActivityIndicatorView.Style

    let color: UIColor

    func makeUIView(context _: UIViewRepresentableContext<ActivityIndicatorView>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context _: UIViewRepresentableContext<ActivityIndicatorView>) {
        uiView.color = color
        uiView.style = style
        uiView.startAnimating()
    }
}

struct ActivityIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicatorView(
            style: .medium,
            color: .red
        )
    }
}
