//
//  HomeView.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/07.
//

import SwiftUI

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
                            VStack {
                                Button(action: {}) {}
                                Text(item.title)
                                if !item.body.isEmpty {
                                    Text(item.body)
                                }
                            }
                        }
                    }

                    Section {
                        Button(action: onClickAddButton) {
                            Text("Add")
                                .foregroundColor(Color(uiColor: UIColor.label))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(R.color.transparent.color)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.red, lineWidth: 2)
                                )
                        }
                        .buttonStyle(.plain)
                        .listRowSeparator(.hidden)
                    }
                }
                .listStyle(.plain)
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
    }

    private func onClickAddButton() {
        let nc = UINavigationController(
            rootViewController: UIViewController.hostingController {
                EditTodoView()
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
