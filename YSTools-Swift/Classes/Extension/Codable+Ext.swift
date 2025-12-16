//
//  Codable+Ext.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2025/12/16.
//

import Foundation

public extension Encodable {
    /// Converts the object to a Dictionary.
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any]
    }
    
    /// Converts the object to a JSON String.
    var jsonString: String? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

public extension Decodable {
    /// Decodes an object from a JSON Data.
    /// - Parameter data: The JSON data.
    /// - Returns: The decoded object or nil if decoding fails.
    static func decode(from data: Data) -> Self? {
        return try? JSONDecoder().decode(Self.self, from: data)
    }
    
    /// Decodes an object from a JSON Dictionary.
    /// - Parameter dictionary: The JSON dictionary.
    /// - Returns: The decoded object or nil if decoding fails.
    static func decode(from dictionary: [String: Any]) -> Self? {
        guard let data = try? JSONSerialization.data(withJSONObject: dictionary, options: []) else { return nil }
        return decode(from: data)
    }
    
    /// Decodes an object from a JSON String.
    /// - Parameter jsonString: The JSON string.
    /// - Returns: The decoded object or nil if decoding fails.
    static func decode(from jsonString: String) -> Self? {
        guard let data = jsonString.data(using: .utf8) else { return nil }
        return decode(from: data)
    }
}
