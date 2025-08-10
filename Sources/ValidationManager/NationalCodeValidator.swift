//
//  File.swift
//  ValidationManager
//
//  Created by Pooyan J on 5/18/1404 AP.
//

import Foundation

public class NationalCodeValidator {

    public var config: Config<String> {
        didSet {
           validationState = validate()
        }
    }
    public var validationState: ValidationState = .notEvaluated

    public init(config: Config<String>, validationState: ValidationState) {
        self.config = config
        self.validationState = validationState
    }

    func validate() -> ValidationState {
        guard !config.input.isEmpty else {
            return .valid
        }

        let digits = config.input.compactMap { Int(String($0)) }

        guard digits.count == 10 else {
            return .invalidLength(error: config.invalidLengthMessage)
        }

        let controlDigit = digits[9]
        var sum = 0

        for i in 0..<9 {
            sum += digits[i] * (10 - i)
        }

        let remainder = sum % 11
        let calculatedControl: Int

        if remainder < 2 {
            calculatedControl = remainder
        } else {
            calculatedControl = 11 - remainder
        }

        if calculatedControl == controlDigit {
            return .valid
        } else {
            return .invalid(error: config.invalidMessage)
        }
    }
}
