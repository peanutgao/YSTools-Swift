//
//  UILabel+Create.swift
//  YSTools-Swift
//
//  Created by Sallie Xiong on 2019/4/30.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit

// MARK: - UILabelCreateProtocol

public protocol UILabelCreateProtocol {}

public extension UILabelCreateProtocol where Self: UILabel {
    @discardableResult
    func ys_text(_ text: String?) -> Self {
        self.text = text
        return self
    }

    @discardableResult
    func ys_font(_ font: UIFont?) -> Self {
        self.font = font
        return self
    }

    @discardableResult
    func ys_textColor(_ color: UIColor?) -> Self {
        self.textColor = color
        return self
    }

    @discardableResult
    func ys_numberOfLines(_ lines: Int) -> Self {
        self.numberOfLines = lines
        return self
    }

    @discardableResult
    func ys_textAlignment(_ alignment: NSTextAlignment) -> Self {
        self.textAlignment = alignment
        return self
    }

    @discardableResult
    func ys_attributedText(_ text: NSAttributedString?) -> Self {
        self.attributedText = text
        return self
    }

    @discardableResult
    func ys_adjustsFontSizeToFitWidth(_ b: Bool = false) -> Self {
        self.adjustsFontSizeToFitWidth = b
        return self
    }

    @discardableResult
    func ys_lineBreakMode(_ mode: NSLineBreakMode = .byWordWrapping) -> Self {
        self.lineBreakMode = mode
        return self
    }
}

// MARK: - UILabel + UILabelCreateProtocol

extension UILabel: UILabelCreateProtocol {}
