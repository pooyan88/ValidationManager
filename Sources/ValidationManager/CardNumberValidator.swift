//
//  CardNumberValidator.swift
//  ValidationManager
//
//  Created by Pooyan J on 5/15/1404 AP.
//

import Foundation

public class CardNumberValidator: Validator {

    public var config: Config<String>
    public var validationState: ValidationState = .notEvaluated
    private var loader = Loader()
    private var banks: [BankModel] = []

    public init(config: Config<String>) {
        self.config = config
       do {
           banks = try loader.Load([BankModel].self, from: "Banks")
       } catch {
           print(error)
       }
    }

    public func validate() -> ValidationState {
        guard !config.input.isEmpty else { return .valid}
        let pureCardNumber = config.input.filter(\.isNumber)

        let allPrefixes = banks.flatMap { $0.prefixes }

        let hasValidPrefix = allPrefixes.contains { pureCardNumber.hasPrefix($0) }
        guard hasValidPrefix else {
            return .invalid(error: config.invalidMessage)
        }

        guard pureCardNumber.count == 16 else {
            return .invalidLength(error: config.invalidLengthMessage)
        }

        if config.input.contains("**") {
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
        return isValid ? .valid : .invalid(error: config.invalidMessage)
    }
}
