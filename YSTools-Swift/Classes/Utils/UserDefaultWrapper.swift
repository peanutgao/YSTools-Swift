//
//  UserDefaultWrapper.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2025/12/16.
//

import Foundation

/// A property wrapper for storing values in UserDefaults.
/// Supports standard types and Codable objects.
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
            // Read value from UserDefaults
            if isOptional {
                return (container.object(forKey: key) as? T) ?? defaultValue
            }
            return (container.object(forKey: key) as? T) ?? defaultValue
        }
        set {
            // Write value to UserDefaults
            if let optional = newValue as? AnyOptional, optional.isNil {
                container.removeObject(forKey: key)
            } else {
                container.set(newValue, forKey: key)
            }
        }
    }
    
    private var isOptional: Bool {
        return T.self is AnyOptional.Type
    }
}

public extension UserDefault where T: Codable {
    var wrappedValue: T {
        get {
            guard let data = container.data(forKey: key) else {
                return defaultValue
            }
            do {
                let value = try JSONDecoder().decode(T.self, from: data)
                return value
            } catch {
                return defaultValue
            }
        }
        set {
            if let optional = newValue as? AnyOptional, optional.isNil {
                container.removeObject(forKey: key)
            } else {
                do {
                    let data = try JSONEncoder().encode(newValue)
                    container.set(data, forKey: key)
                } catch {
                    print("Error encoding \(key): \(error)")
                }
            }
        }
    }
}

// Helper protocol to handle Optional types generically
private protocol AnyOptional {
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    var isNil: Bool { self == nil }
}
