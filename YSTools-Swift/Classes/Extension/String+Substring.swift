//
//  String+Substring.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2019/7/17.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit

public extension String {
    subscript(_ i: Int) -> String {
        guard i >= 0,
              let idx1 = index(startIndex, offsetBy: i, limitedBy: endIndex),
              idx1 < endIndex,
              let idx2 = index(idx1, offsetBy: 1, limitedBy: endIndex) else {
            return ""
        }
        return String(self[idx1 ..< idx2])
    }

    subscript(r: Range<Int>) -> String {
        guard let range = safeRange(from: r.lowerBound, to: r.upperBound, allowClosedEnd: true) else {
            return ""
        }
        let start = range.lowerBound
        let end = range.upperBound
        return String(self[start ..< end])
    }

    subscript(r: CountableClosedRange<Int>) -> String {
        guard let range = safeRange(from: r.lowerBound, to: r.upperBound, allowClosedEnd: false) else {
            return ""
        }
        let startIndex = range.lowerBound
        let endIndex = range.upperBound
        return String(self[startIndex ... endIndex])
    }

    func substring(from index: Int) -> String {
        if index <= 0 {
            return self
        }
        if self.count > index,
           let startIndex = self.index(self.startIndex, offsetBy: index, limitedBy: endIndex) {
            let subString = self[startIndex ..< self.endIndex]

            return String(subString)
        } else {
            return self
        }
    }
}

private extension String {
    func safeRange(from lowerBound: Int, to upperBound: Int, allowClosedEnd: Bool) -> Range<String.Index>? {
        guard lowerBound >= 0, upperBound >= lowerBound else {
            return nil
        }

        guard let start = index(startIndex, offsetBy: lowerBound, limitedBy: endIndex),
              let end = index(startIndex, offsetBy: upperBound, limitedBy: endIndex) else {
            return nil
        }

        if allowClosedEnd {
            return start <= end ? start ..< end : nil
        }
        return start <= end && end < self.endIndex ? start ..< end : nil
    }
}
