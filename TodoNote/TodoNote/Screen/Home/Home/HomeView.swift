//
//  HomeView.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/07.
//

import SwiftUI

/// B-1    ホーム
struct HomeView: View {
    @Environment(\.viewController) private var viewControllerHolder: ViewControllerHolder
    private var viewController: UIViewController? {
        viewControllerHolder.value
    }

    @StateObject var model = HomeViewModel()

    var body: some View {
        ZStack {
            if !model.isLoaded {
                ActivityIndicatorView(
                    style: .medium,
                    color: UIColor.label
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if model.isEmpty {
                HomeEmptyView(
                    action: onClickAddButton
                )
            } else {
                List {
                    Section {
                        ForEach(model.items) { item in
                            TodoItemView(
                                item: item,
                                doneAction: {},
                                editAction: {
                                    onClickEditButton(item: item)
                                }
                            )
                        }
                    }

                    Section {
                        HomeAddView(action: onClickAddButton)
                    }
                }
                .listStyle(.insetGrouped)
            }
        }
        .navigationTitle(Text("Home"))
        .listStyle(.inset)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: onClickAddButton) {
                    Label(
                        "Add",
                        systemImage: "plus"
                    )
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: model.onClickSortButton) {
                    Label(
                        "Sort",
                        systemImage: "list.bullet"
                    )
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: onClickSettingsButton) {
                    Label(
                        R.string.localizable.settings_title(),
                        systemImage: "gearshape"
                    )
                }
            }
            ToolbarItem(placement: .principal) {
                AppTitleView()
            }
        }
        .onAppear {
            model.onAppear(from: viewController)
        }
        .actionSheet(item: $model.actionSheetItem) { $0.sheet }
    }

    private func onClickAddButton() {
        let nc = UINavigationController(
            rootViewController: UIViewController.hostingController {
                EditTodoView(
                    model: EditTodoViewModel(
                        todoId: nil
                    )
                )
            }
        )
        nc.modalPresentationStyle = .fullScreen
        viewController?.present(nc, animated: true)
    }

    private func onClickEditButton(item: Todo) {
        let nc = UINavigationController(
            rootViewController: UIViewController.hostingController {
                EditTodoView(
                    model: EditTodoViewModel(
                        todoId: item.todoId
                    )
                )
            }
        )
        nc.modalPresentationStyle = .fullScreen
        viewController?.present(nc, animated: true)
    }

    private func onClickSettingsButton() {
        let nc = UINavigationController(
            rootViewController: UIViewController.hostingController {
                SettingsView()
            }
        )
        nc.modalPresentationStyle = .fullScreen
        viewController?.present(nc, animated: true)
    }
}
