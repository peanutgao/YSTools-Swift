//
//  UserDefaultWrapper.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2025/12/16.
//

import Foundation

/// A property wrapper for storing values in UserDefaults.
/// Use this for property-list-compatible values such as String, Int, Bool,
/// Array, Dictionary, Data and Date. Use `@CodableUserDefault` for custom
/// Codable types.
@propertyWrapper
public struct UserDefault<T> {
    let key: String
    let defaultValue: T
    var container: UserDefaults = .standard

    public init(key: String, defaultValue: T, container: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.container = container
    }

    public var wrappedValue: T {
        get {
            guard let value = container.object(forKey: key) else {
                return defaultValue
            }

            if let optionalType = T.self as? AnyOptional.Type {
                guard let optionalValue = optionalType.makeOptional(from: value) else {
                    return defaultValue
                }
                return (optionalValue as? T) ?? defaultValue
            }

            return (value as? T) ?? defaultValue
        }
        set {
            if let optional = newValue as? AnyOptional, optional.isNil {
                container.removeObject(forKey: key)
            } else if let optional = newValue as? AnyOptional, let value = optional.wrappedValue {
                setValue(value)
            } else {
                setValue(newValue)
            }
        }
    }

    private func setValue(_ value: Any) {
        guard PropertyListSerialization.propertyList(value, isValidFor: .binary) else {
            #if DEBUG
            debugPrint("[YSTools] UserDefault skipped non-property-list value for key: \(key). Use CodableUserDefault for custom values.")
            #endif
            return
        }
        container.set(value, forKey: key)
    }
}

/// Property wrapper for storing Codable values in UserDefaults.
/// Use this for custom types that conform to Codable. For raw types
/// (String, Int, Bool, etc.) use `@UserDefault` instead.
@propertyWrapper
public struct CodableUserDefault<T: Codable> {
    let key: String
    let defaultValue: T
    var container: UserDefaults

    public init(key: String, defaultValue: T, container: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.container = container
    }

    public var wrappedValue: T {
        get {
            guard let data = container.data(forKey: key) else {
                return defaultValue
            }
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                #if DEBUG
                print("[YSTools] CodableUserDefault decode failed for key=\(key): \(error)")
                #endif
                return defaultValue
            }
        }
        set {
            if let optional = newValue as? AnyOptional, optional.isNil {
                container.removeObject(forKey: key)
                return
            }
            do {
                let data = try JSONEncoder().encode(newValue)
                container.set(data, forKey: key)
            } catch {
                #if DEBUG
                print("[YSTools] CodableUserDefault encode failed for key=\(key): \(error)")
                #endif
            }
        }
    }
}

// Helper protocol to handle Optional types generically
private protocol AnyOptional {
    var isNil: Bool { get }
    var wrappedValue: Any? { get }
    static func makeOptional(from value: Any) -> Any?
}

extension Optional: AnyOptional {
    var isNil: Bool { self == nil }

    var wrappedValue: Any? {
        switch self {
        case .some(let value): return value
        case .none: return nil
        }
    }

    static func makeOptional(from value: Any) -> Any? {
        guard let value = value as? Wrapped else {
            return nil
        }
        return Optional.some(value) as Any
    }
}
