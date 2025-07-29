//
//  Dictionary+Ext.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2019/7/17.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import Foundation

public extension Dictionary {
    enum StringFormat {
        case `default`
        case json
        case jsonPretty
        case keyValue
        case urlQuery
    }

    func toString(format: StringFormat = .default) -> String {
        switch format {
        case .default:
            defaultToString()
        case .json:
            jsonToString()
        case .jsonPretty:
            jsonPrettyToString()
        case .keyValue:
            keyValueToString()
        case .urlQuery:
            urlQueryToString()
        }
    }

    private func defaultToString() -> String {
        String(describing: self)
    }

    private func jsonToString() -> String {
        guard let dict = self as? [String: Any] else {
            return defaultToString()
        }

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: [])
            return String(data: jsonData, encoding: .utf8) ?? defaultToString()
        } catch {
            return defaultToString()
        }
    }

    private func jsonPrettyToString() -> String {
        guard let dict = self as? [String: Any] else {
            return defaultToString()
        }

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
        guard let dict = self as? [String: Any] else {
            return defaultToString()
        }

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

public extension Dictionary {
    func safeValue<T>(for key: Key) -> T? {
        self[key] as? T
    }
}

// MARK: - Array of Dictionary Extensions
public extension Array where Element == [String: Any] {
    enum StringFormat {
        case json
        case jsonPretty
    }
    
    func toString(format: StringFormat = .json) -> String {
        switch format {
        case .json:
            jsonToString()
        case .jsonPretty:
            jsonPrettyToString()
        }
    }
    
    private func jsonToString() -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: [])
            return String(data: jsonData, encoding: .utf8) ?? "[]"
        } catch {
            return "[]"
        }
    }
    
    private func jsonPrettyToString() -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(data: jsonData, encoding: .utf8) ?? "[]"
        } catch {
            return "[]"
        }
    }
}
