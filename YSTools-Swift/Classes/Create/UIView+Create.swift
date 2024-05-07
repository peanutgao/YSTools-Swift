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
}

// MARK: - UIView + UIViewCreateProtocol

extension UIView: UIViewCreateProtocol {}
