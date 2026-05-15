//
//  UIVisualEffectView+Create.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2026/5/15.
//  Copyright © 2026 Joseph Koh. All rights reserved.
//

import UIKit

// MARK: - UIVisualEffectViewCreateProtocol

public protocol UIVisualEffectViewCreateProtocol {}

public extension UIVisualEffectViewCreateProtocol where Self: UIVisualEffectView {
    @discardableResult
    func ys_effect(_ effect: UIVisualEffect?) -> Self {
        self.effect = effect
        return self
    }

    @discardableResult
    func ys_blurStyle(_ style: UIBlurEffect.Style) -> Self {
        self.effect = UIBlurEffect(style: style)
        return self
    }

    @discardableResult
    func ys_addContentSubview(_ view: UIView) -> Self {
        self.contentView.addSubview(view)
        return self
    }
}

extension UIVisualEffectView: UIVisualEffectViewCreateProtocol {}
