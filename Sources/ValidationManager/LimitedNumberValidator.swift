//
//  File.swift
//  ValidationManager
//
//  Created by Pooyan J on 5/19/1404 AP.
//

import Foundation

public class LimitedNumberValidator: Validator {

    public struct Limit: Equatable {
        var number: String
        var min: Int
        var max: Int

        public init(number: String, min: Int, max: Int) {
            self.number = number
            self.min = min
            self.max = max
        }
    }
    public var config: Config<Limit> {
        didSet {
            validationState = validate()
        }
    }
    var validationState: ValidationState = .notEvaluated

    init(config: Config<Limit>) {
        self.config = config
    }

    public func validate() -> ValidationState {
        guard let intNumber = Int(config.input.number) else {
            return .invalid(error: config.invalidMessage)
        }
        if intNumber <= config.input.min && intNumber >= config.input.max {
            return .valid
        } else {
            return .invalidLength(error: config.invalidLengthMessage)
        }
    }
}
