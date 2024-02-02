//
//  UITextView+Placeholder.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2022/2/21.
//  Copyright © 2022 Joseph Koh. All rights reserved.
//

import UIKit

// MARK: - UITextViewPlaceholderProtocol

@objc public protocol UITextViewPlaceholderProtocol {}

public extension UITextViewPlaceholderProtocol where Self: UITextView {
    @discardableResult
    func ys_placeholder(_ placeholder: String?) -> Self {
        self.placeholder = placeholder
        return self
    }
}

// MARK: - UITextView + UITextViewPlaceholderProtocol

extension UITextView: UITextViewPlaceholderProtocol {}
