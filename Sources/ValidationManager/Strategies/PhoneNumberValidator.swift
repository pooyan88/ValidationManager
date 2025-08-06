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

    public var isPhoneNumberValid: Bool {
        return validate().isValid
    }

    public init(config: Config) {
        self.config = config
    }

    public func validate() -> (isValid: Bool, error: String?) {
            let phone = config.phoneNumber.trimmingCharacters(in: .whitespacesAndNewlines)
            guard !phone.isEmpty else { return (true, nil) }

            let startsWithZero = phone.hasPrefix("0")
            let startsWithNine = phone.hasPrefix("9")

            guard startsWithZero || startsWithNine else {
                return (false, config.invalidNumberError)
            }
            if startsWithZero && phone.count != 11 {
                return (false, config.invalidNumberLengthError)
            }
            if startsWithNine && phone.count != 10 {
                return (false, config.invalidNumberLengthError)
            }
            return (true, nil)
        }
}
