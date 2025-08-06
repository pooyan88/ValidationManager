//
//  File.swift
//  ValidationManager
//
//  Created by Pooyan J on 5/15/1404 AP.
//

import Foundation

public class Loader {

    public func Load<T: Codable>(_ type: T.Type, from file: String) throws -> T {
        let url = Bundle.main.url(forResource: file, withExtension: "json")!
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
