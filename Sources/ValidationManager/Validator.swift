//
//  File.swift
//  ValidationManager
//
//  Created by Pooyan J on 5/15/1404 AP.
//

import Foundation

public protocol Validator {
    func validate() -> ValidationState
}

public enum ValidationState: Equatable {
    case notEvaluated, valid, invalid(error: String), invalidLength(error: String)
}

public struct Config<T: Equatable> {
    public var input: T
    public var invalidMessage: String
    public var invalidLengthMessage: String

    public init(input: T, invalidMessage: String, invalidLengthMessage: String) {
        self.input = input
        self.invalidMessage = invalidMessage
        self.invalidLengthMessage = invalidLengthMessage
    }
}
