// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public class ValidationManager: Validator {

    public var strategy: Validator

    public init(strategy: Validator) {
        self.strategy = strategy
    }

    public func validate() -> ValidationState{
        return strategy.validate()
    }
}

