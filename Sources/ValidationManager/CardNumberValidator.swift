//
//  CardNumberValidator.swift
//  ValidationManager
//
//  Created by Pooyan J on 5/15/1404 AP.
//

import Foundation

public class CardNumberValidator: Validator {

    public struct Config {
        public var cardNumber: String
        public var cardValidationError: String
        public var cardLengthValidationError: String

        public init(cardNumber: String, cardValidationError: String, cardLengthValidationError: String) {
            self.cardNumber = cardNumber
            self.cardValidationError = cardValidationError
            self.cardLengthValidationError = cardLengthValidationError
        }
    }

    public var config: Config
    public var validationState: ValidationState = .notEvaluated
    private var loader = Loader()
    private var banks: [BankModel] = []

   public init(config: Config) {
        self.config = config
       do {
           banks = try loader.Load([BankModel].self, from: "Banks")
       } catch {
           print(error)
       }
    }

    public func validate() -> ValidationState {
        guard !config.cardNumber.isEmpty else { return .valid}
        let pureCardNumber = config.cardNumber.filter(\.isNumber)

        let allPrefixes = banks.flatMap { $0.prefixes }

        let hasValidPrefix = allPrefixes.contains { pureCardNumber.hasPrefix($0) }
        guard hasValidPrefix else {
            return .invalidCardNumber(error: config.cardValidationError)
        }

        guard pureCardNumber.count == 16 else {
            return .invalidLength(error: config.cardLengthValidationError)
        }

        if config.cardNumber.contains("**") {
            return .valid
        }

        var sum = 0
        let reversedDigits = pureCardNumber.reversed().map { Int(String($0)) ?? 0 }

        for (index, digit) in reversedDigits.enumerated() {
            var value = digit
            if index % 2 == 1 {
                value *= 2
                if value > 9 {
                    value -= 9
                }
            }
            sum += value
        }

        let isValid = sum % 10 == 0
        return isValid ? .valid : .invalidCardNumber(error: config.cardLengthValidationError)
    }
}
