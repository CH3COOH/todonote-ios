//
//  BaseViewModel.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/11.
//

import SwiftUI

class BaseViewModel: ObservableObject {
    @Published var alertItem: AlertItem?

    @MainActor
    internal func show(error: Error, dismissAction: (() -> Void)? = nil) {
        alertItem = AlertItem(
            alert: Alert(
                title: R.string.localizable.error.text,
                message: Text(error.localizedDescription),
                dismissButton: .default(R.string.localizable.ok.text, action: dismissAction)
            )
        )
    }
}
