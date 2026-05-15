//
//  UITextView+Create.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2019/5/15.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit

// MARK: - UITextViewCreateProtocol

public protocol UITextViewCreateProtocol {}

public extension UITextViewCreateProtocol where Self: UITextView {
    @discardableResult
    func ys_text(_ text: String?) -> Self {
        self.text = text
        return self
    }

    @discardableResult
    func ys_font(_ font: UIFont) -> Self {
        self.font = font
        return self
    }

    @discardableResult
    func ys_textColor(_ color: UIColor) -> Self {
        self.textColor = color
        return self
    }

    @discardableResult
    func ys_textAlignment(_ textAlignment: NSTextAlignment) -> Self {
        self.textAlignment = textAlignment
        return self
    }

    @discardableResult
    func ys_attributedText(_ text: NSAttributedString?) -> Self {
        self.attributedText = text
        return self
    }

    @discardableResult
    func ys_delegate(_ delegate: UITextViewDelegate?) -> Self {
        self.delegate = delegate
        return self
    }

    @discardableResult
    func ys_isEditable(_ b: Bool) -> Self {
        self.isEditable = b
        return self
    }

    @discardableResult
    func ys_isSelectable(_ b: Bool) -> Self {
        self.isSelectable = b
        return self
    }

    @discardableResult
    func ys_isScrollEnabled(_ b: Bool) -> Self {
        self.isScrollEnabled = b
        return self
    }

    @discardableResult
    func ys_dataDetectorTypes(_ types: UIDataDetectorTypes) -> Self {
        self.dataDetectorTypes = types
        return self
    }

    @discardableResult
    func ys_textContainerInset(_ insets: UIEdgeInsets) -> Self {
        self.textContainerInset = insets
        return self
    }

    @discardableResult
    func ys_linkTextAttributes(_ attributes: [NSAttributedString.Key: Any]) -> Self {
        self.linkTextAttributes = attributes
        return self
    }

    @discardableResult
    func ys_keyboardType(_ type: UIKeyboardType) -> Self {
        self.keyboardType = type
        return self
    }

    @discardableResult
    func ys_returnKeyType(_ type: UIReturnKeyType) -> Self {
        self.returnKeyType = type
        return self
    }

    @discardableResult
    func ys_autocapitalizationType(_ type: UITextAutocapitalizationType) -> Self {
        self.autocapitalizationType = type
        return self
    }

    @discardableResult
    func ys_autocorrectionType(_ type: UITextAutocorrectionType) -> Self {
        self.autocorrectionType = type
        return self
    }

    @discardableResult
    func ys_inputView(_ view: UIView?) -> Self {
        self.inputView = view
        return self
    }

    @discardableResult
    func ys_inputAccessoryView(_ view: UIView?) -> Self {
        self.inputAccessoryView = view
        return self
    }

    @discardableResult
    func ys_tintColor(_ color: UIColor) -> Self {
        self.tintColor = color
        return self
    }
}

// MARK: - UITextView + UITextViewCreateProtocol

extension UITextView: UITextViewCreateProtocol {}
