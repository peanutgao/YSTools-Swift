//
//  UISegmentedControl+Create.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2026/5/15.
//  Copyright © 2026 Joseph Koh. All rights reserved.
//

import UIKit

// MARK: - UISegmentedControlCreateProtocol

public protocol UISegmentedControlCreateProtocol {}

public extension UISegmentedControlCreateProtocol where Self: UISegmentedControl {
    @discardableResult
    func ys_selectedSegmentIndex(_ index: Int) -> Self {
        self.selectedSegmentIndex = index
        return self
    }

    @discardableResult
    func ys_isMomentary(_ b: Bool) -> Self {
        self.isMomentary = b
        return self
    }

    @discardableResult
    func ys_apportionsSegmentWidthsByContent(_ b: Bool) -> Self {
        self.apportionsSegmentWidthsByContent = b
        return self
    }

    @discardableResult
    func ys_insertSegment(withTitle title: String?, at index: Int, animated: Bool) -> Self {
        self.insertSegment(withTitle: title, at: index, animated: animated)
        return self
    }

    @discardableResult
    func ys_insertSegment(with image: UIImage?, at index: Int, animated: Bool) -> Self {
        self.insertSegment(with: image, at: index, animated: animated)
        return self
    }

    @discardableResult
    func ys_setTitle(_ title: String?, forSegmentAt index: Int) -> Self {
        self.setTitle(title, forSegmentAt: index)
        return self
    }

    @discardableResult
    func ys_setImage(_ image: UIImage?, forSegmentAt index: Int) -> Self {
        self.setImage(image, forSegmentAt: index)
        return self
    }

    @discardableResult
    func ys_setEnabled(_ enabled: Bool, forSegmentAt index: Int) -> Self {
        self.setEnabled(enabled, forSegmentAt: index)
        return self
    }

    @discardableResult
    func ys_setWidth(_ width: CGFloat, forSegmentAt index: Int) -> Self {
        self.setWidth(width, forSegmentAt: index)
        return self
    }

    @discardableResult
    func ys_setTitleTextAttributes(_ attributes: [NSAttributedString.Key: Any]?, for state: UIControl.State) -> Self {
        self.setTitleTextAttributes(attributes, for: state)
        return self
    }

    @available(iOS 13.0, *)
    @discardableResult
    func ys_selectedSegmentTintColor(_ color: UIColor?) -> Self {
        self.selectedSegmentTintColor = color
        return self
    }
}

extension UISegmentedControl: UISegmentedControlCreateProtocol {}
