//
//  File.swift
//  ValidationManager
//
//  Created by Pooyan J on 5/15/1404 AP.
//

import Foundation

public enum LoaderError: Error, LocalizedError {
    case fileNotFound(String)
    case decodingFailed(Error)

    public var errorDescription: String? {
        switch self {
        case .fileNotFound(let fileName):
            return "File \(fileName).json not found in bundle."
        case .decodingFailed(let error):
            return "Decoding failed: \(error.localizedDescription)"
        }
    }
}

public class Loader {
    public func Load<T: Codable>(_ type: T.Type, from file: String) throws -> T {
        guard let url = Bundle.module.url(forResource: file, withExtension: "json") else {
            throw LoaderError.fileNotFound(file)
        }
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw LoaderError.decodingFailed(error)
        }
    }
}
