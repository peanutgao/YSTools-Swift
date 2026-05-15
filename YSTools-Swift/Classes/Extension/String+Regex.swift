//
//  String+Regex.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2025/12/16.
//

import Foundation

public extension String {
    
    enum RegexPattern: String {
        case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        case phone = "^1[3-9]\\d{9}$" // Basic Chinese mobile phone pattern
        case url = "(http|https)://([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&=]*)?"
        case number = "^[0-9]*$"
        case password = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$" // At least 8 chars, 1 letter, 1 number
    }
    
    /// Checks if the string matches the given regex pattern.
    /// - Parameter pattern: The regex pattern string.
    /// - Returns: True if matches, false otherwise.
    func matches(pattern: String) -> Bool {
        guard let regex = FormatterCache.regex(pattern: pattern) else { return false }
        let range = NSRange(location: 0, length: self.utf16.count)
        return regex.firstMatch(in: self, options: [], range: range) != nil
    }

    /// Checks if the entire string matches the given regex pattern.
    /// - Parameter pattern: The regex pattern string.
    /// - Returns: True if the full string matches, false otherwise.
    func matchesEntirely(pattern: String) -> Bool {
        guard let regex = FormatterCache.regex(pattern: pattern) else { return false }
        let range = NSRange(location: 0, length: self.utf16.count)
        guard let match = regex.firstMatch(in: self, options: [], range: range) else {
            return false
        }
        return match.range.location == range.location && match.range.length == range.length
    }
    
    /// Checks if the string is a valid email.
    var isValidEmail: Bool {
        return matchesEntirely(pattern: RegexPattern.email.rawValue)
    }
    
    /// Checks if the string is a valid phone number (basic check).
    var isValidPhone: Bool {
        return matchesEntirely(pattern: RegexPattern.phone.rawValue)
    }
    
    /// Checks if the string is a valid URL.
    var isValidURL: Bool {
        return matchesEntirely(pattern: RegexPattern.url.rawValue)
    }
    
    /// Checks if the string contains only numbers.
    var isNumber: Bool {
        return matchesEntirely(pattern: RegexPattern.number.rawValue)
    }
    
    /// Extracts all matches of a regex pattern from the string.
    /// - Parameter pattern: The regex pattern.
    /// - Returns: An array of matched strings.
    func extractMatches(pattern: String) -> [String] {
        guard let regex = FormatterCache.regex(pattern: pattern) else { return [] }
        let range = NSRange(location: 0, length: self.utf16.count)
        let matches = regex.matches(in: self, options: [], range: range)

        return matches.map {
            match in
            guard let range = Range(match.range, in: self) else { return "" }
            return String(self[range])
        }
    }
}
