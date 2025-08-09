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

    public enum ErrorType {
        case invalid(error: String), invalidLength(error: String)

        public var message: String {
            switch self {
            case .invalid(error: let message):
                return message
            case .invalidLength(error: let message):
                return message
            }
        }
    }
    public var input: T
    public var errorType: ErrorType

    public init(input: T, errorType: ErrorType) {
        self.input = input
        self.errorType = errorType
    }
}
