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
        Int(self)
    }

    func toFloat() -> Float? {
        Float(self)
    }

    func toDouble() -> Double? {
        Double(self)
    }

    func toInt64() -> Int64? {
        Int64(self)
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
        String(self)
    }

    func toInt() -> Int {
        Int(self)
    }

    func toDouble() -> Double {
        Double(self)
    }

    func toInt64() -> Int64 {
        Int64(self)
    }
}

public extension Double {
    func toString() -> String {
        String(self)
    }

    func toInt() -> Int {
        Int(self)
    }

    func toFloat() -> Float {
        Float(self)
    }

    func toInt64() -> Int64 {
        Int64(self)
    }
}

public extension Int64 {
    func toString() -> String {
        String(self)
    }

    func toInt() -> Int {
        Int(self)
    }

    func toFloat() -> Float {
        Float(self)
    }

    func toDouble() -> Double {
        Double(self)
    }
}
