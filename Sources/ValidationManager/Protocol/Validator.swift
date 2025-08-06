//
//  File.swift
//  ValidationManager
//
//  Created by Pooyan J on 5/15/1404 AP.
//

import Foundation

public protocol Validator {
    func validate() -> (isValid: Bool, error: String?)
}
