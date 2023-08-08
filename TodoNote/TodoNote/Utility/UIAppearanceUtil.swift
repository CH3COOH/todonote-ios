//
//  UIAppearanceUtil.swift
//
//  Created by KENJIWADA on 2023/03/10.
//

import UIKit

struct UIAppearanceUtil {
    static func setup() {
        let newNavBarAppearance = customNavBarAppearance()
        UINavigationBar.appearance().scrollEdgeAppearance = newNavBarAppearance
        UINavigationBar.appearance().compactAppearance = newNavBarAppearance
        UINavigationBar.appearance().standardAppearance = newNavBarAppearance
        UINavigationBar.appearance().compactScrollEdgeAppearance = newNavBarAppearance
        UINavigationBar.appearance().tintColor = R.color.accentColor()

        let newTabBarAppearance = customTabBarAppearance()
        UITabBar.appearance().standardAppearance = newTabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = newTabBarAppearance
        UITabBar.appearance().standardAppearance = newTabBarAppearance
        UITabBar.appearance().tintColor = R.color.accentColor()
    }

    static func customNavBarAppearance() -> UINavigationBarAppearance {
        let customNavBarAppearance = UINavigationBarAppearance()

        customNavBarAppearance.configureWithOpaqueBackground()
        customNavBarAppearance.backgroundColor = R.color.navigationBarBase()

        customNavBarAppearance.titleTextAttributes = [
            .foregroundColor: R.color.textMain()!,
            .font: UIFont.systemFont(ofSize: 18, weight: .bold),
        ]
        customNavBarAppearance.largeTitleTextAttributes = [
            .foregroundColor: R.color.textMain()!,
            .font: UIFont.systemFont(ofSize: 18, weight: .bold),
        ]
        return customNavBarAppearance
    }

    static func customTabBarAppearance() -> UITabBarAppearance {
        let customNavBarAppearance = UITabBarAppearance()

        // Apply a red background.
        customNavBarAppearance.configureWithOpaqueBackground()
        customNavBarAppearance.backgroundColor = R.color.navigationBarBase()

        return customNavBarAppearance
    }
}
