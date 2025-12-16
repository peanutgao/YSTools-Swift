//
//  UIColor+Ext.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2019/5/24.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit

public extension UIColor {
    internal private(set) class var random: UIColor {
        get {
            UIColor(
                red: CGFloat.random(in: 0 ... 1.0),
                green: CGFloat.random(in: 0 ... 1.0),
                blue: CGFloat.random(in: 0 ... 1.0),
                alpha: 1.0
            )
        }
        set {}
    }

    convenience init?(hexString: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            .uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        guard hexFormatted.count == 6 else {
            return nil
        }

        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }

    convenience init(hex: String, alpha: CGFloat = 1.0) {
        if let color = UIColor(hexString: hex, alpha: alpha) {
            self.init(cgColor: color.cgColor)
        } else {
            // Fallback to clear color or handle gracefully instead of crashing
            self.init(white: 0, alpha: 0)
        }
    }

    convenience init(hex: UInt32, alpha: CGFloat = 1.0) {
        let normalizedRed = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let normalizedGreen = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let normalizedBlue = CGFloat(hex & 0x0000FF) / 255.0

        self.init(red: normalizedRed, green: normalizedGreen, blue: normalizedBlue, alpha: alpha)
    }
}
