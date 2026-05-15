//
//  UIButton+CountDown.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2019/6/17.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import ObjectiveC
import UIKit

private var timerHolderAssociatedKey: UInt8 = 0

// Holder cancels timer in deinit so button being released mid-countdown
// (without a manual stopCountDown call) cannot trigger libdispatch's
// "Release of a resumed timer" crash.
private final class CountDownTimerHolder {
  let timer: DispatchSourceTimer
  private var isCancelled = false
  private let lock = NSLock()

  init(timer: DispatchSourceTimer) {
    self.timer = timer
  }

  func cancel() {
    lock.lock()
    defer { lock.unlock() }
    guard !isCancelled else { return }
    isCancelled = true
    timer.cancel()
  }

  deinit {
    cancel()
  }
}

extension UIButton {
  private var countDownTimerHolder: CountDownTimerHolder? {
    get {
      objc_getAssociatedObject(self, &timerHolderAssociatedKey) as? CountDownTimerHolder
    }
    set {
      objc_setAssociatedObject(
        self, &timerHolderAssociatedKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }

  public func startCountDown(
    limitTime: TimeInterval,
    resendTitle: String?,
    waitingEnable: Bool = false,
    waitingTitleFormate: ((Int) -> String)?,
    cancelHandler: (() -> Void)? = nil,
    finishHandler: (() -> Void)? = nil
  ) {
    stopCountDown()

    var timeOut = limitTime - 1

    let queue = DispatchQueue.global()
    let timer = DispatchSource.makeTimerSource(flags: [], queue: queue)
    let holder = CountDownTimerHolder(timer: timer)
    countDownTimerHolder = holder

    let completionHandler = { [weak self, weak holder] in
      holder?.cancel()
      DispatchQueue.main.async { [weak self] in
        guard let self else {
          return
        }
        setTitle(resendTitle, for: .normal)
        isUserInteractionEnabled = true
        isEnabled = true
        countDownTimerHolder = nil
        finishHandler?()
      }
    }

    timer.setEventHandler { [weak self] in
      guard let self else {
        return
      }
      guard timeOut >= 0 else {
        completionHandler()
        return
      }

      let seconds = Int(timeOut) % 60
      DispatchQueue.main.async { [weak self] in
        guard let self else {
          return
        }
        let waitingTitle = waitingTitleFormate?(seconds + 1) ?? "\(seconds + 1)"
        setTitle(" \(waitingTitle) ", for: .disabled)
        isEnabled = false
        isUserInteractionEnabled = waitingEnable
      }

      timeOut -= 1
    }

    timer.setCancelHandler {
      cancelHandler?()
    }
    timer.schedule(deadline: .now(), repeating: 1, leeway: .microseconds(10))
    timer.resume()
  }

  public func stopCountDown() {
    guard let holder = countDownTimerHolder else { return }
    holder.cancel()
    countDownTimerHolder = nil
    isEnabled = true
    isUserInteractionEnabled = true
  }
}
