//
//  Optional+Extras.swift
//  YSTools-Swift
//
//  Created by Codex CLI on 2025/10/17.
//

import Foundation

public extension Optional {
    /// Usage:
    /// let name: String? = nil
    /// let result = name.or("Unknown")  // "Unknown"
    func or(_ defaultValue: Wrapped) -> Wrapped {
        return self ?? defaultValue
    }
}

public extension Optional where Wrapped: Collection {
    /// Usage:
    /// let list: [Int]? = nil
    /// list.isNilOrEmpty  // true
    var isNilOrEmpty: Bool { self?.isEmpty ?? true }

    /// Usage:
    /// let set: Set<Int>? = [1, 2]
    /// set.isNotEmpty  // true
    var isNotEmpty: Bool { !(self?.isEmpty ?? true) }

    /// Usage:
    /// let text: String? = nil
    /// text.countOrZero // 0
    var countOrZero: Int { self?.count ?? 0 }
}

public extension Optional where Wrapped == String {
    /// Usage:
    /// let s: String? = "   "
    /// s.isNilOrBlank // true
    var isNilOrBlank: Bool {
        guard let value = self else { return true }
        return value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    /// Usage:
    /// let name: String? = nil
    /// name.orEmpty // ""
    var orEmpty: String { self ?? "" }

    /// Usage:
    /// let text: String? = "   "
    /// text.nonBlank   // nil
    ///
    /// let text2: String? = "hello"
    /// text2.nonBlank  // "hello"
    var nonBlank: String? {
        guard let value = self else { return nil }
        return value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? nil : value
    }

    /// Usage:
    /// let t: String? = "  hi  "
    /// t.trimmedOrEmpty  // "hi"
    ///
    /// let t2: String? = nil
    /// t2.trimmedOrEmpty // ""
    var trimmedOrEmpty: String {
        self?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    }
}

public extension Optional where Wrapped == Bool {
    /// Usage:
    /// let flag: Bool? = nil
    /// flag.orFalse  // false
    var orFalse: Bool { self ?? false }

    /// Usage:
    /// let f: Bool? = true
    /// f.isTrue // true
    var isTrue: Bool { self == true }

    /// Usage:
    /// let f: Bool? = false
    /// f.isFalse // true
    var isFalse: Bool { self == false }
}

public extension Optional where Wrapped: Numeric {
    /// Usage:
    /// let age: Int? = nil
    /// age.orZero  // 0
    var orZero: Wrapped { self ?? 0 }
}

public extension Optional where Wrapped: Equatable {
    /// Usage:
    /// let status: String? = "done"
    /// status.isEqual("done")  // true
    func isEqual(_ other: Wrapped) -> Bool {
        return self == other
    }
}

public extension Optional {
    /// Usage:
    /// let username: String? = "Alice"
    /// username.ifLet { print("Hello, \($0)") }
    func ifLet(_ action: (Wrapped) -> Void) {
        if let value = self { action(value) }
    }

    /// Usage:
    /// let id: Int? = 5
    /// id.asArray  // [5]
    ///
    /// let empty: Int? = nil
    /// empty.asArray // []
    var asArray: [Wrapped] {
        self.map { [$0] } ?? []
    }
}