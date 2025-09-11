//
//  Dictionary+Ext.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2019/7/17.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import Foundation

public extension Dictionary where Key == String {
    enum StringFormat {
        case `default`
        case json(keepNil: Bool = false)
        case jsonPretty(keepNil: Bool = false)
        case keyValue
        case urlQuery
    }

    func toString(format: StringFormat = .default) -> String {
        switch format {
        case .default:
            return defaultToString()
        case .json(let keepNil):
            return jsonToString(keepNil: keepNil)
        case .jsonPretty(let keepNil):
            return jsonPrettyToString(keepNil: keepNil)
        case .keyValue:
            return keyValueToString()
        case .urlQuery:
            return urlQueryToString()
        }
    }

    private func defaultToString() -> String {
        String(describing: self)
    }

    private func jsonToString(keepNil: Bool) -> String {
        let dict = self.cleanOptionals(keepNil: keepNil)
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: [])
            return String(data: jsonData, encoding: .utf8) ?? defaultToString()
        } catch {
            return defaultToString()
        }
    }

    private func jsonPrettyToString(keepNil: Bool) -> String {
        let dict = self.cleanOptionals(keepNil: keepNil)
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            return String(data: jsonData, encoding: .utf8) ?? defaultToString()
        } catch {
            return defaultToString()
        }
    }

    private func keyValueToString() -> String {
        map { key, value in
            "\(key): \(value)"
        }.joined(separator: ", ")
    }

    private func urlQueryToString() -> String {
        let dict = self.cleanOptionals(keepNil: false) // urlQuery 不应该传 null
        return dict.compactMap { key, value in
            guard let encodedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                  let encodedValue = String(describing: value)
                      .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            else {
                return nil
            }
            return "\(encodedKey)=\(encodedValue)"
        }.joined(separator: "&")
    }
}

// MARK: - Array of Dictionary Extensions
public extension Array where Element == [String: Any] {
    enum StringFormat {
        case json(keepNil: Bool = false)
        case jsonPretty(keepNil: Bool = false)
    }
    
    func toString(format: StringFormat = .json()) -> String {
        switch format {
        case .json(let keepNil):
            return jsonToString(keepNil: keepNil)
        case .jsonPretty(let keepNil):
            return jsonPrettyToString(keepNil: keepNil)
        }
    }
    
    private func jsonToString(keepNil: Bool) -> String {
        let cleaned = self.map { $0.cleanOptionals(keepNil: keepNil) }
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: cleaned, options: [])
            return String(data: jsonData, encoding: .utf8) ?? "[]"
        } catch {
            return "[]"
        }
    }
    
    private func jsonPrettyToString(keepNil: Bool) -> String {
        let cleaned = self.map { $0.cleanOptionals(keepNil: keepNil) }
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: cleaned, options: .prettyPrinted)
            return String(data: jsonData, encoding: .utf8) ?? "[]"
        } catch {
            return "[]"
        }
    }
}
