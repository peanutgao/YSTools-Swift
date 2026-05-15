//
//  UIActivityIndicatorView+Create.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2026/5/15.
//  Copyright © 2026 Joseph Koh. All rights reserved.
//

import UIKit

// MARK: - UIActivityIndicatorViewCreateProtocol

public protocol UIActivityIndicatorViewCreateProtocol {}

public extension UIActivityIndicatorViewCreateProtocol where Self: UIActivityIndicatorView {
    @discardableResult
    func ys_style(_ style: UIActivityIndicatorView.Style) -> Self {
        self.style = style
        return self
    }

    @discardableResult
    func ys_color(_ color: UIColor?) -> Self {
        self.color = color
        return self
    }

    @discardableResult
    func ys_hidesWhenStopped(_ b: Bool) -> Self {
        self.hidesWhenStopped = b
        return self
    }

    @discardableResult
    func ys_startAnimating() -> Self {
        self.startAnimating()
        return self
    }

    @discardableResult
    func ys_stopAnimating() -> Self {
        self.stopAnimating()
        return self
    }
}

extension UIActivityIndicatorView: UIActivityIndicatorViewCreateProtocol {}
