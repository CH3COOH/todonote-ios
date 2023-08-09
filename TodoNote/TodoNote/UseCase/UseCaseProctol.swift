//
//  UseCaseProctol.swift
//
//  Created by KENJIWADA on 2023/08/07.
//

protocol UseCaseProctol<Input, Output> {
    associatedtype Input
    associatedtype Output

    func execute(_ input: Input) async -> Output
}
