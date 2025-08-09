//
//  File.swift
//  ValidationManager
//
//  Created by Pooyan J on 5/15/1404 AP.
//

import Foundation

public class PhoneNumberValidation: Validator {

    public struct Config {
        var phoneNumber: String
        var invalidNumberError: String
        var invalidNumberLengthError: String
    }

    public var config: Config

    public init(config: Config) {
        self.config = config
    }

    public func validate() -> ValidationState{
            let phone = config.phoneNumber.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !phone.isEmpty else { return .valid }

            let startsWithZero = phone.hasPrefix("0")
            let startsWithNine = phone.hasPrefix("9")

            guard startsWithZero || startsWithNine else {
                return .invalidCardNumber(error: config.invalidNumberError)
            }
            if startsWithZero && phone.count != 11 {
                return .invalidLength(error: config.invalidNumberLengthError)
            }
            if startsWithNine && phone.count != 10 {
                return .invalidLength(error: config.invalidNumberLengthError)
            }
            return .valid
        }
}
