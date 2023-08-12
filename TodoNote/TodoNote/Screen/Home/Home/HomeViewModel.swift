//
//  HomeViewModel.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/07.
//

import KRProgressHUD
import SwiftUI

class HomeViewModel: BaseViewModel {
    @Published var actionSheetItem: ActionSheetItem?

    @Published var isLoaded = false

    @Published var items: [TodoSection] = []

    private var sortType: HomeSortType = .standard

    private let fetchTodoListUseCase = FetchTodoListUseCase()

    private let doneTodoUseCase = DoneTodoUseCase()

    var isEmpty: Bool {
        isLoaded && items.isEmpty
    }

    func onAppear(from _: UIViewController?) {
        Task {
            let input = FetchTodoListUseCaseInput(sortType: sortType)
            let result = await fetchTodoListUseCase.execute(input)
            switch result {
            case let .success(items):
                await set(
                    items: items
                )
            case .failed:
                break
            }
        }
    }

    func onClickDoneButton(item: Todo) {
        KRProgressHUD.show()
        Task {
            let result = await doneTodoUseCase.execute(.init(todo: item))
            KRProgressHUD.dismiss()
            switch result {
            case .success:
                await delete(deletedItem: item)
            case let .failed(error):
                await show(error: error)
            }
        }
    }

    func onClickSortButton() {
        var buttons: [ActionSheet.Button] = HomeSortType.allCases.map { type in
            .default(Text(type.title)) {
                self.sortType = type
                self.onAppear(from: nil)
            }
        }
        buttons.append(.cancel())

        actionSheetItem = ActionSheetItem(
            sheet: ActionSheet(
                title: R.string.localizable.home_dialog_sort_title.text,
                buttons: buttons
            )
        )
    }

    // MARK: -

    @MainActor
    private func set(items: [TodoSection]) {
        isLoaded = true
        self.items = items
    }

    @MainActor
    private func delete(deletedItem _: Todo) {
        withAnimation {
//            items.removeAll(
//                where: {
//                    $0.todoId == deletedItem.todoId
//                }
//            )
        }
    }
}
