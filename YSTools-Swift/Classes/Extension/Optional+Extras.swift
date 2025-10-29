//
//  Optional+Extras.swift
//  YSTools-Swift
//
//  Created by Codex CLI on 2025/10/17.
//

import Foundation

public extension Optional where Wrapped: Collection {
    /// Returns true when the optional is nil or the wrapped collection is empty
    var isNilOrEmpty: Bool { self?.isEmpty ?? true }

    /// Returns true only when the optional is non-nil and the wrapped collection is not empty
    var isNotEmpty: Bool {
        guard let value = self else { return false }
        return !value.isEmpty
    }
}

public extension Optional where Wrapped == String {
    /// Returns true when the string is nil or contains only whitespaces/newlines
    var isNilOrBlank: Bool {
        guard let value = self else { return true }
        return value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    /// Returns the wrapped value or an empty string
    var orEmpty: String { self ?? "" }

    /// Returns the wrapped value if it contains non-blank text; otherwise nil
    var nonBlank: String? {
        guard let value = self else { return nil }
        return value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? nil : value
    }
}

public extension Optional where Wrapped == Bool {
    /// Returns wrapped value or false
    var orFalse: Bool { self ?? false }
}

public extension Optional where Wrapped == Int {
    /// Returns wrapped value or 0
    var orZero: Int { self ?? 0 }
}

public extension Optional where Wrapped == Double {
    /// Returns wrapped value or 0.0
    var orZero: Double { self ?? 0.0 }
}

