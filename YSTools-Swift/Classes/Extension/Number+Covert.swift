//
//  Number+Covert.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2019/7/17.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import Foundation

public extension String {
    func toInt() -> Int? {
        if let intValue = Int(self) {
            return intValue
        }
        if let doubleValue = Double(self),
           doubleValue.canConvertToInt {
            return Int(exactly: doubleValue.rounded(.towardZero))
        }
        return nil
    }

    func toFloat() -> Float? {
        Float(self)
    }

    func toDouble() -> Double? {
        Double(self)
    }

    func toInt64() -> Int64? {
        if let int64Value = Int64(self) {
            return int64Value
        }
        if let doubleValue = Double(self),
           doubleValue.canConvertToInt64 {
            return Int64(exactly: doubleValue.rounded(.towardZero))
        }
        return nil
    }
}

public extension Int {
    func toString() -> String {
        String(self)
    }

    func toFloat() -> Float {
        Float(self)
    }

    func toDouble() -> Double {
        Double(self)
    }

    func toInt64() -> Int64 {
        Int64(self)
    }
}

public extension Float {
    func toString() -> String {
        String(format: "%g", self)
    }

    func toInt() -> Int {
        Double(self).clampedInt()
    }

    func toDouble() -> Double {
        Double(self)
    }

    func toInt64() -> Int64 {
        Double(self).clampedInt64()
    }
}

public extension Double {
    func toString() -> String {
        String(format: "%g", self)
    }

    func toInt() -> Int {
        clampedInt()
    }

    func toFloat() -> Float {
        Float(self)
    }

    func toInt64() -> Int64 {
        clampedInt64()
    }
}

public extension Int64 {
    func toString() -> String {
        String(self)
    }

    func toInt() -> Int? {
        if self >= Int.min, self <= Int.max {
            return Int(self)
        }
        return nil
    }

    func toFloat() -> Float {
        Float(self)
    }

    func toDouble() -> Double {
        Double(self)
    }
}

private extension Double {
    var canConvertToInt: Bool {
        isFinite && self >= Double(Int.min) && self <= Double(Int.max)
    }

    var canConvertToInt64: Bool {
        isFinite && self >= Double(Int64.min) && self <= Double(Int64.max)
    }

    func clampedInt() -> Int {
        guard isFinite else {
            return 0
        }
        if self >= Double(Int.max) {
            return Int.max
        }
        if self <= Double(Int.min) {
            return Int.min
        }
        return Int(self)
    }

    func clampedInt64() -> Int64 {
        guard isFinite else {
            return 0
        }
        if self >= Double(Int64.max) {
            return Int64.max
        }
        if self <= Double(Int64.min) {
            return Int64.min
        }
        return Int64(self)
    }
}
