//
//  SplashView.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/07.
//

import SwiftUI

/// A-1    スプラッシュ
struct SplashView: View {
    @Environment(\.viewController) private var viewControllerHolder: ViewControllerHolder
    private var viewController: UIViewController? {
        viewControllerHolder.value
    }

    @StateObject var model = SplashViewModel()

    var body: some View {
        ZStack(alignment: .center) {
            ActivityIndicatorView(
                style: .medium,
                color: UIColor.secondaryLabel
            )
        }
        .onAppear {
            model.onAppear(from: viewController)
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
