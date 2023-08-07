//
//  HomeViewModel.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/07.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var isLoaded = false

    @Published var items: [Todo] = []

    var isEmpty: Bool {
        isLoaded && items.isEmpty
    }

    func onAppear(from _: UIViewController?) {
        Task {
//            let result = await fetchCardListUseCase.execute(.init())
//            switch result {
//            case let .success(cards):
//                await set(
//                    cards: cards
//                )
//            case .failed:
//                // TODO: エラー時の処理
//                break
//            }

            await set(items: [])
        }
    }

    @MainActor
    private func set(items: [Todo]) {
        isLoaded = true
        self.items = items
    }
}
