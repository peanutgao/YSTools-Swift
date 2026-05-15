//
//  UIDatePicker+Create.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2026/5/15.
//  Copyright © 2026 Joseph Koh. All rights reserved.
//

import UIKit

// MARK: - UIDatePickerCreateProtocol

public protocol UIDatePickerCreateProtocol {}

public extension UIDatePickerCreateProtocol where Self: UIDatePicker {
    @discardableResult
    func ys_datePickerMode(_ mode: UIDatePicker.Mode) -> Self {
        self.datePickerMode = mode
        return self
    }

    @discardableResult
    func ys_locale(_ locale: Locale?) -> Self {
        self.locale = locale
        return self
    }

    @discardableResult
    func ys_calendar(_ calendar: Calendar) -> Self {
        self.calendar = calendar
        return self
    }

    @discardableResult
    func ys_timeZone(_ timeZone: TimeZone?) -> Self {
        self.timeZone = timeZone
        return self
    }

    @discardableResult
    func ys_date(_ date: Date) -> Self {
        self.date = date
        return self
    }

    @discardableResult
    func ys_setDate(_ date: Date, animated: Bool) -> Self {
        self.setDate(date, animated: animated)
        return self
    }

    @discardableResult
    func ys_minimumDate(_ date: Date?) -> Self {
        self.minimumDate = date
        return self
    }

    @discardableResult
    func ys_maximumDate(_ date: Date?) -> Self {
        self.maximumDate = date
        return self
    }

    @discardableResult
    func ys_minuteInterval(_ minutes: Int) -> Self {
        self.minuteInterval = minutes
        return self
    }

    @discardableResult
    func ys_countDownDuration(_ seconds: TimeInterval) -> Self {
        self.countDownDuration = seconds
        return self
    }

    @available(iOS 13.4, *)
    @discardableResult
    func ys_preferredDatePickerStyle(_ style: UIDatePickerStyle) -> Self {
        self.preferredDatePickerStyle = style
        return self
    }
}

extension UIDatePicker: UIDatePickerCreateProtocol {}
