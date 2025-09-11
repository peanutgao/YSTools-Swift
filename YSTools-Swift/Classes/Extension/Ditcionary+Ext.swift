//
//  Ditcionary+Ext.swift
//  YSTools-Swift
//
//  Created by Joseph on 2025/9/11.
//

import Foundation

public protocol JSONValueTransformable {
    func transformToJSONValue() -> Any?
}

extension String: JSONValueTransformable {
    public func transformToJSONValue() -> Any? { self }
}

extension Int: JSONValueTransformable {
    public func transformToJSONValue() -> Any? { self }
}

extension Double: JSONValueTransformable {
    public func transformToJSONValue() -> Any? { self }
}

extension Bool: JSONValueTransformable {
    public func transformToJSONValue() -> Any? { self }
}

extension Array: JSONValueTransformable where Element: JSONValueTransformable {
    public func transformToJSONValue() -> Any? {
        compactMap { $0.transformToJSONValue() }
    }
}

extension Dictionary: JSONValueTransformable where Value: JSONValueTransformable {
    public func transformToJSONValue() -> Any? {
        var result: [Key: Any] = [:]
        forEach { key, value in
            if let transformed = value.transformToJSONValue() {
                result[key] = transformed
            }
        }
        return result
    }
}

extension Optional: JSONValueTransformable where Wrapped: JSONValueTransformable {
    public func transformToJSONValue() -> Any? {
        switch self {
        case .none:
            nil
        case let .some(value):
            value.transformToJSONValue()
        }
    }
}

public extension Dictionary where Key == String {
    func cleanOptionals(keepNil: Bool = false) -> [String: Any] {
        var result: [String: Any] = [:]

        for (key, value) in self {
//            if String(describing: type(of: value)).contains("Optional") {
//                debugPrint("⚠️ Warning: Optional value detected for key '\(key)' with type '\(type(of: value))'")
//            }

            if let transformable = value as? JSONValueTransformable,
               let transformed = transformable.transformToJSONValue() {
                result[key] = transformed
            }
            else if let dict = value as? [String: Any] {
                result[key] = dict.cleanOptionals(keepNil: keepNil)
            }
            else if let array = value as? [Any] {
                result[key] = array.map { element -> Any in
//                    if String(describing: type(of: element)).contains("Optional") {
//                        debugPrint(
//                            "⚠️ Warning: Optional value detected in array for key '\(key)' with type '\(type(of: element))'"
//                        )
//                    }

                    if let dict = element as? [String: Any] {
                        return dict.cleanOptionals(keepNil: keepNil)
                    }
                    if let transformable = element as? JSONValueTransformable,
                       let transformed = transformable.transformToJSONValue() {
                        return transformed
                    }
                    return element
                }
            }
            else if case Optional<Any>.none = value {
                if keepNil {
                    result[key] = NSNull()
                }
            }
            else {
                result[key] = value
            }
        }

        return result
    }
}
