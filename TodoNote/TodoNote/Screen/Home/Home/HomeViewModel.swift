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

    @Published var actionSheetItem: ActionSheetItem?

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
//                break
//            }
            do {
                let resitory = TodoRepository()
                let items = try await resitory.fetch()

                await set(items: items)
            }
        }
    }

    func onClickSortButton() {
        actionSheetItem = ActionSheetItem(
            sheet: ActionSheet(
                title: Text("あああああ"),
                buttons: [
                    .default(Text("期限切れのみ")),
                    .default(Text("期限切れのみ")),
                    .cancel(),
                ]
            )
        )
    }

    // MARK: -

    @MainActor
    private func set(items: [Todo]) {
        isLoaded = true
        self.items = items
    }
}
