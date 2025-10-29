//
//  Collection+Extras.swift
//  YSTools-Swift
//
//  Created by Codex CLI on 2025/10/17.
//

import Foundation

public extension Collection {
    /// Convenience to check non-empty collections
    var isNotEmpty: Bool { !isEmpty }
}

public extension Collection {
    /// Safe index access to avoid out-of-bounds crashes
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

