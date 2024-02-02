//
//  UIControl+Create.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2019/7/31.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit

// MARK: - UIControlCreateProtocol

public protocol UIControlCreateProtocol {}

public extension UIControlCreateProtocol where Self: UIControl {
    @discardableResult
    func ys_isEnable(_ isEnabled: Bool) -> Self {
        self.isEnabled = isEnabled
        return self
    }

    @discardableResult
    func ys_isSelected(_ isSelected: Bool) -> Self {
        self.isSelected = isSelected
        return self
    }

    @discardableResult
    func ys_addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) -> Self {
        self.addTarget(target, action: action, for: controlEvents)
        return self
    }
}

// MARK: - UIButton + UIControlCreateProtocol

extension UIButton: UIControlCreateProtocol {}

// MARK: - UISwitch + UIControlCreateProtocol

extension UISwitch: UIControlCreateProtocol {}
