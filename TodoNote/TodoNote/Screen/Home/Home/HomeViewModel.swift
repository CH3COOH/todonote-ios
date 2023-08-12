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

    private let fetchTodoListUseCase = FetchTodoListUseCase()

    private let doneTodoUseCase = DoneTodoUseCase()

    var isEmpty: Bool {
        isLoaded && items.isEmpty
    }

    func onAppear(from _: UIViewController?) {
        Task {
            let input = FetchTodoListUseCaseInput(sortType: .hogehoge)
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
