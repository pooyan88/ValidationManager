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
    public var isValid: Bool {
        return validate().isValid
    }
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

    public func validate() -> (isValid: Bool, error: String?) {
        guard !config.cardNumber.isEmpty else { return (true, "")}
        let pureCardNumber = config.cardNumber.filter(\.isNumber)

        let allPrefixes = banks.flatMap { $0.prefixes }

        let hasValidPrefix = allPrefixes.contains { pureCardNumber.hasPrefix($0) }
        guard hasValidPrefix else {
            return (false, config.cardValidationError)
        }

        guard pureCardNumber.count == 16 else {
            return (false, config.cardLengthValidationError)
        }

        if config.cardNumber.contains("**") {
            return (true, nil)
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
        return (isValid, isValid ? nil : config.cardValidationError)
    }
}
