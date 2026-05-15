//
//  UIGestureRecognizer+Create.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2026/5/15.
//  Copyright © 2026 Joseph Koh. All rights reserved.
//

import UIKit

// MARK: - UIGestureRecognizerCreateProtocol

public protocol UIGestureRecognizerCreateProtocol {}

public extension UIGestureRecognizerCreateProtocol where Self: UIGestureRecognizer {
    @discardableResult
    func ys_isEnabled(_ b: Bool) -> Self {
        self.isEnabled = b
        return self
    }

    @discardableResult
    func ys_cancelsTouchesInView(_ b: Bool) -> Self {
        self.cancelsTouchesInView = b
        return self
    }

    @discardableResult
    func ys_delaysTouchesBegan(_ b: Bool) -> Self {
        self.delaysTouchesBegan = b
        return self
    }

    @discardableResult
    func ys_delaysTouchesEnded(_ b: Bool) -> Self {
        self.delaysTouchesEnded = b
        return self
    }

    @discardableResult
    func ys_delegate(_ delegate: UIGestureRecognizerDelegate?) -> Self {
        self.delegate = delegate
        return self
    }

    @discardableResult
    func ys_addTarget(_ target: Any, action: Selector) -> Self {
        self.addTarget(target, action: action)
        return self
    }

    @discardableResult
    func ys_requireToFail(_ other: UIGestureRecognizer) -> Self {
        self.require(toFail: other)
        return self
    }
}

extension UIGestureRecognizer: UIGestureRecognizerCreateProtocol {}

public extension UITapGestureRecognizer {
    @discardableResult
    func ys_numberOfTapsRequired(_ count: Int) -> Self {
        self.numberOfTapsRequired = count
        return self
    }

    @discardableResult
    func ys_numberOfTouchesRequired(_ count: Int) -> Self {
        self.numberOfTouchesRequired = count
        return self
    }
}

public extension UILongPressGestureRecognizer {
    @discardableResult
    func ys_minimumPressDuration(_ duration: TimeInterval) -> Self {
        self.minimumPressDuration = duration
        return self
    }

    @discardableResult
    func ys_allowableMovement(_ movement: CGFloat) -> Self {
        self.allowableMovement = movement
        return self
    }

    @discardableResult
    func ys_numberOfTapsRequired(_ count: Int) -> Self {
        self.numberOfTapsRequired = count
        return self
    }

    @discardableResult
    func ys_numberOfTouchesRequired(_ count: Int) -> Self {
        self.numberOfTouchesRequired = count
        return self
    }
}

public extension UIPanGestureRecognizer {
    @discardableResult
    func ys_minimumNumberOfTouches(_ count: Int) -> Self {
        self.minimumNumberOfTouches = count
        return self
    }

    @discardableResult
    func ys_maximumNumberOfTouches(_ count: Int) -> Self {
        self.maximumNumberOfTouches = count
        return self
    }
}

public extension UISwipeGestureRecognizer {
    @discardableResult
    func ys_direction(_ direction: UISwipeGestureRecognizer.Direction) -> Self {
        self.direction = direction
        return self
    }

    @discardableResult
    func ys_numberOfTouchesRequired(_ count: Int) -> Self {
        self.numberOfTouchesRequired = count
        return self
    }
}

public extension UIPinchGestureRecognizer {
    @discardableResult
    func ys_scale(_ scale: CGFloat) -> Self {
        self.scale = scale
        return self
    }
}

public extension UIRotationGestureRecognizer {
    @discardableResult
    func ys_rotation(_ rotation: CGFloat) -> Self {
        self.rotation = rotation
        return self
    }
}
