//
//  File.swift
//  ValidationManager
//
//  Created by Pooyan J on 5/15/1404 AP.
//

import Foundation

public class ValidationManager: Validator {

    var strategy: Validator

    init(strategy: Validator) {
        self.strategy = strategy
    }

    public func validate() -> (isValid: Bool, error: String?) {
        return strategy.validate()
    }
}
