//
//  File.swift
//  ValidationManager
//
//  Created by Pooyan J on 5/19/1404 AP.
//

import Foundation

public class CardSecurityValidator: Validator {

    public enum SecurityType: Equatable {
        case pin(text: String, min: Int, max: Int), cvv2(text: String, min: Int, max: Int)
    }

    public var config: Config<SecurityType> {
        didSet {
            validationState = validate()
        }
    }
    var validationState: ValidationState = .notEvaluated

    public init(config: Config<SecurityType>) {
        self.config = config
    }

    public func validate() -> ValidationState {
        switch config.input {
        case .cvv2(let text, let min, let max):
            return validateCVV2(cvv2: text, min: min, max: max)
        case .pin(let text, let min, let max):
            return validatePin(pin: text, min: min, max: max)
        }
    }

    private func validateCVV2(cvv2: String, min: Int, max: Int) -> ValidationState {
        if cvv2.isEmpty {
            return .valid
        }
        let numericCvv2 = cvv2.filter { $0.isNumber }

        guard numericCvv2.count == cvv2.count else {
            return .invalid(error: config.invalidMessage)
        }

        if numericCvv2.count >= min && numericCvv2.count <= max {
            return .valid
        } else {
            return .invalidLength(error: config.invalidLengthMessage)
        }
    }

    private func validatePin(pin: String, min: Int, max: Int) -> ValidationState {
        if pin.isEmpty {
            return .valid
        }
        let numericPin = pin.filter { $0.isNumber }

        guard numericPin.count == pin.count else {
            return .invalid(error: config.invalidMessage)
        }

        if numericPin.count >= min && numericPin.count <= max {
            return .valid
        } else {
            return .invalidLength(error: config.invalidLengthMessage)
        }
    }
}
