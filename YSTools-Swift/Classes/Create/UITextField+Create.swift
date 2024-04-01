//
//  UITextField+Create.swift
//  YSTools-Swift
//
//  Created by Sallie Xiong on 2019/5/6.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit

// MARK: - UITextFieldCreateProtocol

public protocol UITextFieldCreateProtocol {
}

public extension UITextFieldCreateProtocol where Self: UITextField {
    @discardableResult
    func ys_text(_ text: String?) -> Self {
        if let text {
            self.text = text
        }
        return self
    }

    @discardableResult
    func ys_font(_ font: UIFont?) -> Self {
        if let font {
            self.font = font
        }
        return self
    }

    @discardableResult
    func ys_textColor(_ color: UIColor?) -> Self {
        if let color {
            self.textColor = color
        }
        return self
    }

    @discardableResult
    func ys_textAlignment(_ alignment: NSTextAlignment) -> Self {
        self.textAlignment = alignment
        return self
    }

    @discardableResult
    func ys_placeholder(_ placeholder: String?) -> Self {
        if let placeholder {
            self.placeholder = placeholder
        }
        return self
    }

    @discardableResult
    func ys_attributedPlaceholder(_ attributedPlaceholder: NSAttributedString?) -> Self {
        if let attributedPlaceholder {
            self.attributedPlaceholder = attributedPlaceholder
        }
        return self
    }

    @discardableResult
    func ys_borderStyle(_ style: UITextField.BorderStyle) -> Self {
        self.borderStyle = style
        return self
    }

    @discardableResult
    func ys_keyboardType(_ type: UIKeyboardType) -> Self {
        self.keyboardType = type
        return self
    }

    @discardableResult
    func ys_delegate(_ delegate: UITextFieldDelegate) -> Self {
        self.delegate = delegate
        return self
    }

    @discardableResult
    func ys_clearButtonMode(_ mode: UITextField.ViewMode) -> Self {
        self.clearButtonMode = mode
        return self
    }

    @discardableResult
    func ys_adjustsFontSizeToFitWidth(_ b: Bool = false) -> Self {
        self.adjustsFontSizeToFitWidth = b
        return self
    }
    
    @discardableResult
    func ys_leftView(_ leftView: UIView) -> Self {
        self.leftView = leftView
        return self
    }
    
    @discardableResult
    func ys_leftViewMode(_ leftViewMode: UITextField.ViewMode) -> Self {
        self.leftViewMode = leftViewMode
        return self
    }
}

// MARK: - UITextField + UITextFieldCreateProtocol

extension UITextField: UITextFieldCreateProtocol {
}
