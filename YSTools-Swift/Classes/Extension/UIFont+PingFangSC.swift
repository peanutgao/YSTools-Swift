//
//  UIFont+PingFang.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2019/6/4.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit

@objc public extension UIFont {
    @objc enum PingFangWeight: Int {
        case regular, medium, semibold, bold, light, thin

        var fontName: String {
            switch self {
            case .regular: "PingFangSC-Regular"
            case .medium: "PingFangSC-Medium"
            case .semibold: "PingFangSC-Semibold"
            case .bold: "PingFangSC-Bold"
            case .light: "PingFangSC-Light"
            case .thin: "PingFangSC-Thin"
            }
        }
    }

    @available(*, deprecated, message: "Use `pingFangSC(_:, size:)` instead")
    @objc class func pingFangFont(ofSize fontSize: CGFloat) -> UIFont {
        UIFont(name: PingFangWeight.regular.fontName, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }

    @available(*, deprecated, message: "Use `pingFangSC(_:, size:)` instead")
    @objc class func mediumPingFangFont(ofSize fontSize: CGFloat) -> UIFont {
        UIFont(name: PingFangWeight.medium.fontName, size: fontSize) ?? UIFont.boldSystemFont(ofSize: fontSize)
    }

    @available(*, deprecated, message: "Use `pingFangSC(_:, size:)` instead")
    @objc class func boldPingFangFont(ofSize fontSize: CGFloat) -> UIFont {
        UIFont(name: PingFangWeight.bold.fontName, size: fontSize) ?? UIFont.boldSystemFont(ofSize: fontSize)
    }

    @available(*, deprecated, message: "Use `pingFangSC(_:, size:)` instead")
    @objc class func semiboldPingFangFont(ofSize fontSize: CGFloat) -> UIFont {
        UIFont(name: PingFangWeight.semibold.fontName, size: fontSize) ?? UIFont.boldSystemFont(ofSize: fontSize)
    }

    @objc class func pingFangSC(ofSize fontSize: CGFloat, weight: PingFangWeight = .regular) -> UIFont {
        UIFont(name: weight.fontName, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
}
