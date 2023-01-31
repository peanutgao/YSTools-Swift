//
//  UITextView+Placeholder.swift
//  SCDoctor
//
//  Created by Joseph Koh on 2022/2/21.
//  Copyright © 2022 Joseph Koh. All rights reserved.
//

import UIKit

@objc public protocol UITextViewPlaceholderProtocol {
    
}

public extension UITextViewPlaceholderProtocol where Self: UITextView {
    @discardableResult
    public func ys_placeholder(_ placeholder: String?) -> Self {
        self.placeholder = placeholder
        return self
    }
}

extension UITextView: UITextViewPlaceholderProtocol {
}

