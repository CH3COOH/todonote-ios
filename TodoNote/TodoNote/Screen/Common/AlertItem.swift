//
//  AlertItem.swift
//

import SwiftUI

struct AlertItem: Identifiable {
    var id = UUID()
    var alert: Alert
}

struct ActionSheetItem: Identifiable {
    var id = UUID()
    var sheet: ActionSheet
}

struct SheetItem<T: View>: Identifiable {
    var id = UUID()
    var view: T
}
