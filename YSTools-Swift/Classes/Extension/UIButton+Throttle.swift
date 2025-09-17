//
// *************************************************
// Created by Joseph Koh on 2024/1/8.
// Author: Joseph Koh
// Email: Joseph0750@gmail.com
// Create Date: 2024/1/8 15:47
// *************************************************
//

import UIKit

private var throttleIntervalKey: UInt8 = 0
private var isThrottlingKey: UInt8 = 0
private var throttledActionKey: UInt8 = 0
private var throttleGuardsInstalledKey: UInt8 = 0
private var suppressWhileThrottlingKey: UInt8 = 0
private var throttleEventsKey: UInt8 = 0

extension UIButton {
  private var throttleInterval: TimeInterval {
    get {
      objc_getAssociatedObject(self, &throttleIntervalKey) as? TimeInterval ?? 0
    }
    set {
      objc_setAssociatedObject(
        self, &throttleIntervalKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
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
      objc_setAssociatedObject(
        self, &throttledActionKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }

  private var throttleGuardsInstalled: Bool {
    get {
      objc_getAssociatedObject(self, &throttleGuardsInstalledKey) as? Bool ?? false
    }
    set {
      objc_setAssociatedObject(
        self, &throttleGuardsInstalledKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }

  // 以 raw 值的方式记录已注册的事件掩码，避免直接桥接 OptionSet 导致的不确定性
  private var throttleEventsRaw: UInt {
    get {
      (objc_getAssociatedObject(self, &throttleEventsKey) as? UInt) ?? 0
    }
    set {
      objc_setAssociatedObject(
        self, &throttleEventsKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }

  private var throttleEvents: UIControl.Event {
    get { UIControl.Event(rawValue: throttleEventsRaw) }
    set { throttleEventsRaw = newValue.rawValue }
  }

  public var ysSuppressWhileThrottling: Bool {
    get {
      objc_getAssociatedObject(self, &suppressWhileThrottlingKey) as? Bool ?? true
    }
    set {
      objc_setAssociatedObject(
        self,
        &suppressWhileThrottlingKey,
        newValue,
        .OBJC_ASSOCIATION_RETAIN_NONATOMIC
      )
    }
  }

  @objc private func throttleTouchDown(_ sender: UIButton) {
    guard ysSuppressWhileThrottling else { return }
    guard isThrottling else { return }
    sender.isHighlighted = false
    sender.cancelTracking(with: nil)
  }

  @objc private func throttledClick(_ sender: UIButton) {
    if isThrottling {
      #if DEBUG
        debugPrint("click action had been throttled!!!")
      #endif
      if ysSuppressWhileThrottling { sender.isHighlighted = false }
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

    removeTarget(self, action: #selector(throttledClick(_:)), for: event)
    addTarget(self, action: #selector(throttledClick(_:)), for: event)

    self.throttleEvents = self.throttleEvents.union(event)
    if !throttleGuardsInstalled {
      addTarget(self, action: #selector(throttleTouchDown(_:)), for: .touchDown)
      throttleGuardsInstalled = true
    }
    return self
  }
}
