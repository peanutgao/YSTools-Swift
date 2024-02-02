//
// *************************************************
// Created by Joseph Koh on 2024/1/8.
// Author: Joseph Koh
// Email: Joseph0750@gmail.com
// Create Time: 2024/1/8 15:47
// *************************************************
//

import UIKit

private var throttleIntervalKey: UInt8 = 0
private var isThrottlingKey: UInt8 = 0
private var throttledActionKey: UInt8 = 0

extension UIButton {
    private var throttleInterval: TimeInterval {
        get {
            objc_getAssociatedObject(self, &throttleIntervalKey) as? TimeInterval ?? 0
        }
        set {
            objc_setAssociatedObject(self, &throttleIntervalKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    private var isThrottling: Bool {
        get {
            objc_getAssociatedObject(self, &isThrottlingKey) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &isThrottlingKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    private var throttledAction: ((UIButton) -> Void)? {
        get {
            objc_getAssociatedObject(self, &throttledActionKey) as? (UIButton) -> Void
        }
        set {
            objc_setAssociatedObject(self, &throttledActionKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    @objc private func throttledClick(_ sender: UIButton) {
        if isThrottling {
            debugPrint("click action had been throttled!!!")
            return
        }
        isThrottling = true

        sender.throttledAction?(sender)
        DispatchQueue.main.asyncAfter(deadline: .now() + self.throttleInterval) { [weak self] in
            self?.isThrottling = false
        }
    }

    public func addThrottledAction(
        interval: TimeInterval = 1.0,
        for event: UIControl.Event,
        action: @escaping (UIButton) -> Void
    ) {
        _ = ys_addThrottledAction(interval: interval, for: event, action: action)
    }

    @discardableResult
    public func ys_addThrottledAction(
        interval: TimeInterval = 1.0,
        for event: UIControl.Event,
        action: @escaping (UIButton) -> Void
    ) -> Self {
        self.throttleInterval = interval
        self.throttledAction = action
        addTarget(self, action: #selector(throttledClick(_:)), for: event)
        return self
    }
}
