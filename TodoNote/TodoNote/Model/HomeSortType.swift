//
//  HomeSortType.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/12.
//

enum HomeSortType {
    case standard
    case createdAt(isAscending: Bool)
    case updatedAt(isAscending: Bool)
}

extension HomeSortType: CaseIterable {
    static var allCases: [HomeSortType] {
        [
            .standard,
            .createdAt(isAscending: true),
            .createdAt(isAscending: false),
            .updatedAt(isAscending: true),
            .updatedAt(isAscending: false),
        ]
    }
}

extension HomeSortType {
    var title: String {
        switch self {
        case .standard:
            return R.string.localizable.home_sort_standard()
        case let .createdAt(isAscending):
            let sort = isAscending ? R.string.localizable.ascending() : R.string.localizable.descending()

            return "\(R.string.localizable.create_date()) (\(sort))"
        case let .updatedAt(isAscending):
            let sort = isAscending ? R.string.localizable.ascending() : R.string.localizable.descending()

            return "\(R.string.localizable.modified_date()) (\(sort))"
        }
    }
}
