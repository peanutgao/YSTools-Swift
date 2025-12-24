//
//  String+Group.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2024/9/4.
//
//  该扩展为 String 提供了分组功能，支持按不同的规则对字符串进行分组。
//

import Foundation

public extension String {
    /// 按照指定的分组大小数组 `groupSizes` 对字符串进行分组，并在分组之间插入分隔符。
    /// - Parameters:
    ///   - groupSizes: 一个整数数组，表示每组的字符数量。
    ///   - separator: 分组之间的分隔符，默认为空格。
    /// - Returns: 分组后的字符串。
    /// - 使用示例：
    /// ```swift
    /// let str = "123456789"
    /// let grouped = str.grouped(by: [3, 2, 4], separator: "-")
    /// print(grouped) // 输出："123-45-6789"
    /// ```
    func grouped(by groupSizes: [Int], separator: String = " ") -> String {
        var result = ""
        var currentIndex = startIndex

        for (index, size) in groupSizes.enumerated() {
            guard currentIndex < self.endIndex else {
                break
            }

            let endIndex = self.index(currentIndex, offsetBy: size, limitedBy: endIndex) ?? endIndex
            let substring = self[currentIndex ..< endIndex]

            if !result.isEmpty {
                result += separator
            }
            result += String(substring)

            currentIndex = endIndex
        }

        // handle the remaining
        if currentIndex < endIndex {
            if !result.isEmpty {
                result += separator
            }
            result += String(self[currentIndex...])
        }

        return result
    }

    /// 按照固定的分组大小 `size` 对字符串进行分组，并在分组之间插入分隔符。
    /// - Parameters:
    ///   - size: 每组的字符数量。
    ///   - separator: 分组之间的分隔符，默认为空格。
    /// - Returns: 分组后的字符串。
    /// - 使用示例：
    /// ```swift
    /// let str = "123456789"
    /// let grouped = str.grouped(every: 3, with: "-")
    /// print(grouped) // 输出："123-456-789"
    /// ```
    func grouped(every size: Int, with separator: String = " ") -> String {
        guard size > 0 else {
            return self
        }

        var result = ""
        var currentIndex = startIndex

        while currentIndex < endIndex {
            if !result.isEmpty {
                result += separator
            }

            let endIndex = index(currentIndex, offsetBy: size, limitedBy: endIndex) ?? endIndex
            result += String(self[currentIndex ..< endIndex])
            currentIndex = endIndex
        }

        return result
    }

    /// 按照指定的分组模式 `pattern` 对字符串进行分组，并在分组之间插入分隔符。
    /// - Parameters:
    ///   - pattern: 一个元组数组，每个元组包含分组大小和重复次数。
    ///   - separator: 分组之间的分隔符，默认为空格。
    /// - Returns: 分组后的字符串。
    /// - 使用示例：
    /// ```swift
    /// let str = "123456789"
    /// let grouped = str.groupedByPattern([(3, 2), (2, 1)], separator: "-")
    /// print(grouped) // 输出："123-456-78-9"
    /// ```
    func groupedByPattern(_ pattern: [(size: Int, repeat: Int)], separator: String = " ") -> String {
        var result = ""
        var currentIndex = startIndex

        for (size, repeatCount) in pattern {
            for _ in 0 ..< repeatCount {
                guard currentIndex < self.endIndex else {
                    break
                }

                let endIndex = index(currentIndex, offsetBy: size, limitedBy: endIndex) ?? endIndex
                let substring = self[currentIndex ..< endIndex]

                if !result.isEmpty {
                    result += separator
                }
                result += String(substring)

                currentIndex = endIndex

                if currentIndex >= self.endIndex {
                    break
                }
            }
        }

        if currentIndex < endIndex {
            if !result.isEmpty {
                result += separator
            }
            result += String(self[currentIndex...])
        }

        return result
    }
}
