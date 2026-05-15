//
//  UIView+Create.swift
//  YSTools-Swift
//
//  Created by Sallie Xiong on 2019/4/28.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit

// MARK: - UIViewCreateProtocol

public protocol UIViewCreateProtocol {}

public extension UIViewCreateProtocol where Self: UIView {
    @discardableResult
    func ys_inView(_ inView: UIView?) -> Self {
        if let v = inView {
            v.addSubview(self)
        }
        return self
    }

    @discardableResult
    func ys_frame(_ frame: CGRect) -> Self {
        self.frame = frame
        return self
    }

    @discardableResult
    func ys_backgroundColor(_ color: UIColor) -> Self {
        self.backgroundColor = color
        return self
    }

    @discardableResult
    func ys_setCorner(radius: CGFloat, clickToBounds: Bool) -> Self {
        layer.cornerRadius = radius
        return ys_clickToBounds(b: clickToBounds)
    }

    @discardableResult
    func ys_setBorder(width: CGFloat, color: UIColor) -> Self {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        return self
    }

    @discardableResult
    func ys_clickToBounds(b: Bool) -> Self {
        self.clipsToBounds = b
        return self
    }

    @discardableResult
    func ys_addSubview(_ view: UIView) -> Self {
        addSubview(view)
        return self
    }

    @discardableResult
    func ys_tag(_ tag: Int) -> Self {
        self.tag = tag
        return self
    }

    @discardableResult
    func ys_isHidden(_ b: Bool) -> Self {
        self.isHidden = b
        return self
    }

    @discardableResult
    func ys_alpha(_ alpha: CGFloat) -> Self {
        self.alpha = alpha
        return self
    }

    @discardableResult
    func ys_isUserInteractionEnabled(_ b: Bool) -> Self {
        self.isUserInteractionEnabled = b
        return self
    }

    @discardableResult
    func ys_contentMode(_ mode: ContentMode) -> Self {
        self.contentMode = mode
        return self
    }

    @discardableResult
    func ys_addGestureRecognizer(_ gesture: UIGestureRecognizer) -> Self {
        self.addGestureRecognizer(gesture)
        return self
    }

    @discardableResult
    func ys_tintColor(_ color: UIColor) -> Self {
        self.tintColor = color
        return self
    }

    @discardableResult
    func ys_transform(_ transform: CGAffineTransform) -> Self {
        self.transform = transform
        return self
    }

    @discardableResult
    func ys_mask(_ mask: UIView?) -> Self {
        self.mask = mask
        return self
    }

    @discardableResult
    func ys_translatesAutoresizingMaskIntoConstraints(_ b: Bool) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = b
        return self
    }

    @discardableResult
    func ys_autoresizingMask(_ mask: UIView.AutoresizingMask) -> Self {
        self.autoresizingMask = mask
        return self
    }

    @discardableResult
    func ys_semanticContentAttribute(_ attribute: UISemanticContentAttribute) -> Self {
        self.semanticContentAttribute = attribute
        return self
    }

    @discardableResult
    func ys_accessibilityIdentifier(_ identifier: String?) -> Self {
        self.accessibilityIdentifier = identifier
        return self
    }

    @discardableResult
    func ys_accessibilityLabel(_ label: String?) -> Self {
        self.accessibilityLabel = label
        return self
    }

    @discardableResult
    func ys_isAccessibilityElement(_ b: Bool) -> Self {
        self.isAccessibilityElement = b
        return self
    }

    @discardableResult
    func ys_layoutMargins(_ insets: UIEdgeInsets) -> Self {
        self.layoutMargins = insets
        return self
    }

    @discardableResult
    func ys_preservesSuperviewLayoutMargins(_ b: Bool) -> Self {
        self.preservesSuperviewLayoutMargins = b
        return self
    }

    @discardableResult
    func ys_setShadow(color: UIColor, offset: CGSize, radius: CGFloat, opacity: Float) -> Self {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        return self
    }

    @discardableResult
    func ys_masksToBounds(_ b: Bool) -> Self {
        layer.masksToBounds = b
        return self
    }

    @discardableResult
    func ys_removeFromSuperview() -> Self {
        self.removeFromSuperview()
        return self
    }

    @discardableResult
    func ys_addSubviews(_ views: [UIView]) -> Self {
        views.forEach { addSubview($0) }
        return self
    }

    @discardableResult
    func ys_addSubviews(_ views: UIView...) -> Self {
        views.forEach { addSubview($0) }
        return self
    }

    @discardableResult
    func ys_setContentHuggingPriority(_ priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) -> Self {
        self.setContentHuggingPriority(priority, for: axis)
        return self
    }

    @discardableResult
    func ys_setContentCompressionResistancePriority(_ priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) -> Self {
        self.setContentCompressionResistancePriority(priority, for: axis)
        return self
    }
}

// MARK: - UIView + UIViewCreateProtocol

extension UIView: UIViewCreateProtocol {}
