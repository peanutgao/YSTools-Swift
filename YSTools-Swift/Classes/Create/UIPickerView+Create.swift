//
//  UIPickerView+Create.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2026/5/15.
//  Copyright © 2026 Joseph Koh. All rights reserved.
//

import UIKit

// MARK: - UIPickerViewCreateProtocol

public protocol UIPickerViewCreateProtocol {}

public extension UIPickerViewCreateProtocol where Self: UIPickerView {
    @discardableResult
    func ys_dataSource(_ dataSource: UIPickerViewDataSource?) -> Self {
        self.dataSource = dataSource
        return self
    }

    @discardableResult
    func ys_delegate(_ delegate: UIPickerViewDelegate?) -> Self {
        self.delegate = delegate
        return self
    }

    @discardableResult
    func ys_selectRow(_ row: Int, inComponent component: Int, animated: Bool) -> Self {
        self.selectRow(row, inComponent: component, animated: animated)
        return self
    }

    @discardableResult
    func ys_reloadAllComponents() -> Self {
        self.reloadAllComponents()
        return self
    }

    @discardableResult
    func ys_reloadComponent(_ component: Int) -> Self {
        self.reloadComponent(component)
        return self
    }
}

extension UIPickerView: UIPickerViewCreateProtocol {}
