//
//  UIButton+CountDown.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2019/6/17.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit

public extension UIButton {
    func startCountDown(
        limitTime: TimeInterval,
        resendTitle: String?,
        waitingEnable: Bool = false,
        waitingTitleFormate: ((Int) -> String)?,
        finishHandler: (() -> Void)? = nil
    ) {
        var timeOut = limitTime - 1

        let queue = DispatchQueue.global()
        let timer = DispatchSource.makeTimerSource(flags: [], queue: queue)

        let completionHandler = { [weak self] in
            timer.cancel()
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.setTitle(resendTitle, for: .normal)
                self.isUserInteractionEnabled = true
                self.isEnabled = true
                finishHandler?()
            }
        }

        timer.setEventHandler { [weak self] in
            guard let self = self else { return }
            guard timeOut >= 0 else {
                DispatchQueue.main.async {
                    self.setTitle(resendTitle, for: .disabled)
                    completionHandler()
                }
                return
            }

            let seconds = Int(timeOut) % 60
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                let waitingTitle = waitingTitleFormate?(seconds + 1) ?? "\(seconds + 1)"
                self.setTitle(" \(waitingTitle) ", for: .disabled)
                self.isEnabled = false
                self.isUserInteractionEnabled = waitingEnable
            }

            timeOut -= 1
        }

        timer.setCancelHandler {
            completionHandler()
        }
        timer.schedule(deadline: .now(), repeating: 1, leeway: .microseconds(10))
        timer.resume()
    }
}
