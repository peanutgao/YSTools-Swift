//
// *************************************************
// Created by Joseph Koh on 2024/1/14.
// Author: Joseph Koh
// Email: Joseph0750@gmail.com
// Create Date: 2024/12/4
// *************************************************
//

import Foundation

public extension String {
    func toDictionary() -> [String: Any]? {
        guard !isEmpty, let data = data(using: .utf8) else {
            return nil
        }

        do {
            if let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                return dict
            }
        } catch {
            print("JSON Serialization Error: \(error.localizedDescription)")
        }
        return nil
    }

    ///  "name=John&age=25" -> ["name": "John", "age": "25"]
    func toQueryDictionary() -> [String: String] {
        var dict: [String: String] = [:]

        let pairs = components(separatedBy: "&")
        for pair in pairs {
            let elements = pair.components(separatedBy: "=")
            if elements.count == 2 {
                let key = elements[0].removingPercentEncoding ?? elements[0]
                let value = elements[1].removingPercentEncoding ?? elements[1]
                dict[key] = value
            }
        }

        return dict
    }

    // "key1:value1;key2:value2" -> ["key1": "value1", "key2": "value2"]
    func toCustomDictionary(keyValueSeparator: String = ":", pairSeparator: String = ";") -> [String: String] {
        var dict: [String: String] = [:]

        let pairs = components(separatedBy: pairSeparator)
        for pair in pairs {
            let elements = pair.components(separatedBy: keyValueSeparator)
            if elements.count == 2 {
                let key = elements[0].trimmingCharacters(in: .whitespaces)
                let value = elements[1].trimmingCharacters(in: .whitespaces)
                dict[key] = value
            }
        }

        return dict
    }
}
