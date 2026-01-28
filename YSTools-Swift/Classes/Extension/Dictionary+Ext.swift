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

/// 使用 Mirror 解包被装箱成 Any 的 Optional 值
/// - Parameter value: 任意值
/// - Returns: 如果是 Optional 则返回解包后的值（可能为 nil），否则返回原值
private func unwrapOptionalValue(_ value: Any) -> Any? {
    let mirror = Mirror(reflecting: value)
    if mirror.displayStyle == .optional {
        if let (_, unwrapped) = mirror.children.first {
            // 递归解包嵌套的 Optional
            return unwrapOptionalValue(unwrapped)
        }
        return nil // Optional.none
    }
    return value
}

public extension Dictionary where Key == String {
    /// 清理字典中的 Optional 值
    /// - Parameter keepNil: 是否保留 nil 值（转换为 NSNull），默认为 false
    /// - Returns: 清理后的字典
    func cleanOptionals(keepNil: Bool = false) -> [String: Any] {
        var result: [String: Any] = [:]

        for (key, value) in self {
            // 首先使用 Mirror 解包可能被装箱的 Optional
            guard let unwrapped = unwrapOptionalValue(value) else {
                if keepNil {
                    result[key] = NSNull()
                }
                continue
            }

            // 优先检查嵌套字典和数组，避免被 JSONValueTransformable 错误匹配
            if let dict = unwrapped as? [String: Any?] {
                result[key] = dict.cleanOptionals(keepNil: keepNil)
            } else if let dict = unwrapped as? [String: Any] {
                result[key] = dict.cleanOptionals(keepNil: keepNil)
            } else if let array = unwrapped as? [Any] {
                result[key] = cleanArray(array, keepNil: keepNil)
            } else if let transformable = unwrapped as? JSONValueTransformable,
                      let transformed = transformable.transformToJSONValue() {
                result[key] = transformed
            } else {
                result[key] = unwrapped
            }
        }

        return result
    }

    private func cleanArray(_ array: [Any], keepNil: Bool) -> [Any] {
        array.compactMap { element -> Any? in
            guard let unwrapped = unwrapOptionalValue(element) else {
                return keepNil ? NSNull() : nil
            }

            // 优先检查嵌套字典和数组
            if let dict = unwrapped as? [String: Any?] {
                return dict.cleanOptionals(keepNil: keepNil)
            }
            if let dict = unwrapped as? [String: Any] {
                return dict.cleanOptionals(keepNil: keepNil)
            }
            if let nestedArray = unwrapped as? [Any] {
                return cleanArray(nestedArray, keepNil: keepNil)
            }
            if let transformable = unwrapped as? JSONValueTransformable,
               let transformed = transformable.transformToJSONValue() {
                return transformed
            }
            return unwrapped
        }
    }

    /// 移除字典中值为 nil 的键值对（支持递归处理嵌套字典和数组）
    /// - Returns: 返回一个新字典，其中不包含值为 nil 的键值对
    func removingNilValues() -> [String: Any] {
        cleanOptionals(keepNil: false)
    }
}
