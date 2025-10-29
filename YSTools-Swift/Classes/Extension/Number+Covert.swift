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
        if let doubleValue = Double(self) {
            return Int(doubleValue)
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
        if let doubleValue = Double(self) {
            return Int64(doubleValue)
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
        let result = Int(self)
        if self > Float(Int.max) || self < Float(Int.min) {
            assertionFailure("Float value \(self) is out of Int range [\(Int.min), \(Int.max)]")
        }
        return result
    }

    func toDouble() -> Double {
        Double(self)
    }

    func toInt64() -> Int64 {
        let result = Int64(self)
        if self > Float(Int64.max) || self < Float(Int64.min) {
            assertionFailure("Float value \(self) is out of Int64 range [\(Int64.min), \(Int64.max)]")
        }
        return result
    }
}

public extension Double {
    func toString() -> String {
        String(format: "%g", self)
    }

    func toInt() -> Int {
        let result = Int(self)
        if self > Double(Int.max) || self < Double(Int.min) {
            assertionFailure("Double value \(self) is out of Int range [\(Int.min), \(Int.max)]")
        }
        return result
    }

    func toFloat() -> Float {
        Float(self)
    }

    func toInt64() -> Int64 {
        let result = Int64(self)
        if self > Double(Int64.max) || self < Double(Int64.min) {
            assertionFailure("Double value \(self) is out of Int64 range [\(Int64.min), \(Int64.max)]")
        }
        return result
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
        assertionFailure("Int64 value \(self) is out of Int range [\(Int.min), \(Int.max)]")
        return nil
    }

    func toFloat() -> Float {
        Float(self)
    }

    func toDouble() -> Double {
        Double(self)
    }
}
