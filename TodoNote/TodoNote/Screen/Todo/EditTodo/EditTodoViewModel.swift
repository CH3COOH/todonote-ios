//
//  EditTodoViewModel.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/07.
//

import SwiftUI

class EditTodoViewModel: ObservableObject {
    @Published var title = ""

    @Published var body = ""

    @Published var date = Date()
}
