//
//  UIBarButtonItem+Create.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2026/5/15.
//  Copyright © 2026 Joseph Koh. All rights reserved.
//

import UIKit

// MARK: - UIBarButtonItemCreateProtocol

public protocol UIBarButtonItemCreateProtocol {}

public extension UIBarButtonItemCreateProtocol where Self: UIBarButtonItem {
    @discardableResult
    func ys_title(_ title: String?) -> Self {
        self.title = title
        return self
    }

    @discardableResult
    func ys_image(_ image: UIImage?) -> Self {
        self.image = image
        return self
    }

    @discardableResult
    func ys_landscapeImagePhone(_ image: UIImage?) -> Self {
        self.landscapeImagePhone = image
        return self
    }

    @discardableResult
    func ys_style(_ style: UIBarButtonItem.Style) -> Self {
        self.style = style
        return self
    }

    @discardableResult
    func ys_tintColor(_ color: UIColor?) -> Self {
        self.tintColor = color
        return self
    }

    @discardableResult
    func ys_isEnabled(_ b: Bool) -> Self {
        self.isEnabled = b
        return self
    }

    @discardableResult
    func ys_target(_ target: AnyObject?) -> Self {
        self.target = target
        return self
    }

    @discardableResult
    func ys_action(_ action: Selector?) -> Self {
        self.action = action
        return self
    }

    @discardableResult
    func ys_width(_ width: CGFloat) -> Self {
        self.width = width
        return self
    }

    @discardableResult
    func ys_imageInsets(_ insets: UIEdgeInsets) -> Self {
        self.imageInsets = insets
        return self
    }

    @discardableResult
    func ys_setTitleTextAttributes(_ attributes: [NSAttributedString.Key: Any]?, for state: UIControl.State) -> Self {
        self.setTitleTextAttributes(attributes, for: state)
        return self
    }

    @discardableResult
    func ys_setBackgroundImage(_ image: UIImage?, for state: UIControl.State, barMetrics: UIBarMetrics) -> Self {
        self.setBackgroundImage(image, for: state, barMetrics: barMetrics)
        return self
    }
}

extension UIBarButtonItem: UIBarButtonItemCreateProtocol {}
