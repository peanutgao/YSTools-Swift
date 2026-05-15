//
//  UISlider+Create.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2026/5/15.
//  Copyright © 2026 Joseph Koh. All rights reserved.
//

import UIKit

// MARK: - UISliderCreateProtocol

public protocol UISliderCreateProtocol {}

public extension UISliderCreateProtocol where Self: UISlider {
    @discardableResult
    func ys_value(_ value: Float) -> Self {
        self.value = value
        return self
    }

    @discardableResult
    func ys_setValue(_ value: Float, animated: Bool) -> Self {
        self.setValue(value, animated: animated)
        return self
    }

    @discardableResult
    func ys_minimumValue(_ value: Float) -> Self {
        self.minimumValue = value
        return self
    }

    @discardableResult
    func ys_maximumValue(_ value: Float) -> Self {
        self.maximumValue = value
        return self
    }

    @discardableResult
    func ys_isContinuous(_ b: Bool) -> Self {
        self.isContinuous = b
        return self
    }

    @discardableResult
    func ys_minimumTrackTintColor(_ color: UIColor?) -> Self {
        self.minimumTrackTintColor = color
        return self
    }

    @discardableResult
    func ys_maximumTrackTintColor(_ color: UIColor?) -> Self {
        self.maximumTrackTintColor = color
        return self
    }

    @discardableResult
    func ys_thumbTintColor(_ color: UIColor?) -> Self {
        self.thumbTintColor = color
        return self
    }

    @discardableResult
    func ys_setThumbImage(_ image: UIImage?, for state: UIControl.State) -> Self {
        self.setThumbImage(image, for: state)
        return self
    }

    @discardableResult
    func ys_setMinimumTrackImage(_ image: UIImage?, for state: UIControl.State) -> Self {
        self.setMinimumTrackImage(image, for: state)
        return self
    }

    @discardableResult
    func ys_setMaximumTrackImage(_ image: UIImage?, for state: UIControl.State) -> Self {
        self.setMaximumTrackImage(image, for: state)
        return self
    }

    @discardableResult
    func ys_minimumValueImage(_ image: UIImage?) -> Self {
        self.minimumValueImage = image
        return self
    }

    @discardableResult
    func ys_maximumValueImage(_ image: UIImage?) -> Self {
        self.maximumValueImage = image
        return self
    }
}

extension UISlider: UISliderCreateProtocol {}
