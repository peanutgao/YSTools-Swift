//
//  UIStepper+Create.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2026/5/15.
//  Copyright © 2026 Joseph Koh. All rights reserved.
//

import UIKit

// MARK: - UIStepperCreateProtocol

public protocol UIStepperCreateProtocol {}

public extension UIStepperCreateProtocol where Self: UIStepper {
    @discardableResult
    func ys_value(_ value: Double) -> Self {
        self.value = value
        return self
    }

    @discardableResult
    func ys_minimumValue(_ value: Double) -> Self {
        self.minimumValue = value
        return self
    }

    @discardableResult
    func ys_maximumValue(_ value: Double) -> Self {
        self.maximumValue = value
        return self
    }

    @discardableResult
    func ys_stepValue(_ value: Double) -> Self {
        self.stepValue = value
        return self
    }

    @discardableResult
    func ys_isContinuous(_ b: Bool) -> Self {
        self.isContinuous = b
        return self
    }

    @discardableResult
    func ys_autorepeat(_ b: Bool) -> Self {
        self.autorepeat = b
        return self
    }

    @discardableResult
    func ys_wraps(_ b: Bool) -> Self {
        self.wraps = b
        return self
    }
}

extension UIStepper: UIStepperCreateProtocol {}
