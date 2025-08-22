//
//  UIButton+CountDown.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2019/6/17.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import ObjectiveC
import UIKit

private var timerAssociatedKey: UInt8 = 0

extension UIButton {
  private var countDownTimer: DispatchSourceTimer? {
    get {
      objc_getAssociatedObject(self, &timerAssociatedKey) as? DispatchSourceTimer
    }
    set {
      objc_setAssociatedObject(
        self, &timerAssociatedKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
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
    countDownTimer = timer

    let completionHandler = { [weak self] in
      timer.cancel()
      DispatchQueue.main.async { [weak self] in
        guard let self else {
          return
        }
        setTitle(resendTitle, for: .normal)
        isUserInteractionEnabled = true
        isEnabled = true
        countDownTimer = nil
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
    if let timer = countDownTimer, !timer.isCancelled {
      timer.cancel()
      countDownTimer = nil
      isEnabled = true
      isUserInteractionEnabled = true
    }
  }
}
