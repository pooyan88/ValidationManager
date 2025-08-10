//
//  File.swift
//  ValidationManager
//
//  Created by Pooyan J on 5/15/1404 AP.
//

import Foundation

public class PhoneNumberValidation: Validator {

    public var config: Config<String> {
        didSet {
             validationState = validate()
        }
    }

    public var validationState: ValidationState = .notEvaluated


    public init(config: Config<String>) {
        self.config = config
    }

    public func validate() -> ValidationState {
            let phone = config.input.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !phone.isEmpty else { return .valid }

            let startsWithZero = phone.hasPrefix("0")
            let startsWithNine = phone.hasPrefix("9")

            guard startsWithZero || startsWithNine else {
                return .invalid(error: config.invalidMessage)
            }
            if startsWithZero && phone.count != 11 {
                return .invalidLength(error: config.invalidLengthMessage)
            }
            if startsWithNine && phone.count != 10 {
                return .invalidLength(error: config.invalidLengthMessage)
            }
            return .valid
        }
}
