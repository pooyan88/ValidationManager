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

    var config: Config<SecurityType> {
        didSet {
            validationState = validate()
        }
    }
    var validationState: ValidationState = .notEvaluated

    init(config: Config<SecurityType>) {
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
        let numericCvv2 = cvv2.filter({$0.isNumber})
        let intCVV2 = Int(numericCvv2) ?? 0
        if intCVV2 >= min && intCVV2 <= max {
            return .valid
        } else {
            return .invalidLength(error: config.invalidLengthMessage)
        }
    }

    private func validatePin(pin: String, min: Int, max: Int) -> ValidationState {
        let numericPin = pin.filter({$0.isNumber})
        let IntPin = Int(numericPin) ?? 0
        if IntPin >= min && IntPin <= max {
            return .valid
        } else {
            return .invalidLength(error: config.invalidLengthMessage)
        }
    }
}
