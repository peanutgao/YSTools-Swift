//
//  String+Replace.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2024/4/12.
//

import Foundation

public extension String {
    var trimmedWhitespaces: String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var removedBlank: String {
        replacingOccurrences(of: " ", with: "")
    }
}
