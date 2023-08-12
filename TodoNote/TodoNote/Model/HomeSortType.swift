//
//  HomeSortType.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/12.
//

enum HomeSortType {
    case hogehoge
//    case createAt(isAscending: Bool)
//    case updateAt(isAscending: Bool)
}

extension HomeSortType: CaseIterable {
    static var allCases: [HomeSortType] {
        [
            hogehoge,
//            createAt(isAscending: true),
//            createAt(isAscending: false),
//            updateAt(isAscending: true),
//            updateAt(isAscending: false),
        ]
    }
}

extension HomeSortType {
    var title: String {
        switch self {
        case .hogehoge:
            return "時間順"
//        case let .createAt(isAscending: isAscending):
//            return isAscending ? "タスクの作成日順(昇順)" : "タスクの作成日順(降順)"
//        case .updateAt(isAscending: let isAscending):
//            "時間順"
        }
    }
}
